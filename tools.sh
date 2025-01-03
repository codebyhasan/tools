#!/bin/bash

# Update package list
echo "Updating package list..."
sudo apt update

# Install essential tools
echo "Installing essential tools..."
sudo apt install -y \
    neofetch \

# Install speedtest-cli
echo "Installing speedtest-cli..."
sudo apt-get install curl && curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash && sudo apt-get install speedtest

# Clean up
echo "Cleaning up..."
sudo apt autoremove -y

echo "All tools have been installed successfully!"
