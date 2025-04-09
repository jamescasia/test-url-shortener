# Use a base image
FROM python:slim

# Set the working directory
WORKDIR /app

# Copy package files and install dependencies
COPY requirements.txt ./
RUN pip install -r requirements.txt

# Copy the rest of the code
COPY . .

# Expose a port
EXPOSE 8080

# Command to run the app
CMD ["python3", "app.py"]
