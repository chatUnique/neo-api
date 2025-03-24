# Use the base image for neo-api
FROM pengzhile/new-api:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the environment file (if needed)
COPY neo-api.env /app/neo-api.env

# Expose the port used by the application
EXPOSE 3000

# Set the command to run the application
CMD ["--log-dir", "/app/logs"]
