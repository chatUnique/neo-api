# Stage 1: neo-api service
FROM pengzhile/new-api:latest AS neo-api
WORKDIR /app
COPY neo-api.env /app/neo-api.env
VOLUME ["/data", "/app/logs"]
EXPOSE 3000
CMD ["--log-dir", "/app/logs"]

# Stage 2: redis service
FROM redis:7.4 AS redis
VOLUME ["/data"]

# Stage 3: mysql service
FROM mysql:8.2 AS mysql
ENV TZ=Asia/Shanghai
ENV MYSQL_ROOT_PASSWORD=NeoAPI@123
ENV MYSQL_USER=neo-api
ENV MYSQL_PASSWORD=123456
ENV MYSQL_DATABASE=neo-api
VOLUME ["/var/lib/mysql"]

# Final stage: Combine all services
FROM ubuntu:20.04 AS final
COPY --from=neo-api /app /neo-api
COPY --from=redis /data /redis-data
COPY --from=mysql /var/lib/mysql /mysql-data

# Expose ports for all services
EXPOSE 3000 6379 3306

# Command to start all services
CMD ["sh", "-c", "service redis-server start && service mysql start && /neo-api --log-dir /neo-api/logs"]
