FROM pengzhile/new-api:latest

WORKDIR /app

# 复制配置文件
COPY neo-api.env /app/neo-api.env

# 创建日志目录
RUN mkdir -p /app/logs

# 暴露应用端口
EXPOSE 3000

# 启动命令
CMD ["/app/neo-api", "--log-dir", "/app/logs"]
