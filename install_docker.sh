#!/bin/bash

# Update the package database
echo "Updating package database..."
sudo apt-get update -y

# Install dependencies required for Docker installation
echo "Installing required dependencies..."
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common jq

# Add Docker's official GPG key
echo "Adding Docker's official GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set up the Docker stable repository
echo "Setting up Docker repository..."
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package database again with Docker's repository
echo "Updating package database with Docker repository..."
sudo apt-get update -y

# Install Docker Engine
echo "Installing Docker..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Start Docker service and enable it to start on boot
echo "Starting and enabling Docker..."
sudo systemctl start docker
sudo systemctl enable docker

# Verify Docker installation
echo "Verifying Docker installation..."
sudo docker --version

# Install Docker Compose (latest stable version)
echo "Installing Docker Compose..."
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r .tag_name)
sudo curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Apply executable permissions to Docker Compose
echo "Setting permissions for Docker Compose..."
sudo chmod +x /usr/local/bin/docker-compose

# Verify Docker Compose installation
echo "Verifying Docker Compose installation..."
docker-compose --version

# Finish
echo "Docker and Docker Compose installation complete!"
