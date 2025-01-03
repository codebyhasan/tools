#!/bin/bash

# Update package list
echo "Updating package list..."
sudo apt update

# Install essential tools
echo "Installing essential tools..."
sudo apt install -y \
    neofetch

# Install speedtest-cli
echo "Installing speedtest-cli..."
sudo apt-get install -y curl && \
    curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash && \
    sudo apt-get install -y speedtest

# Install FFmpeg
echo "Installing FFmpeg..."
sudo apt install -y ffmpeg

# Verify FFmpeg installation
if command -v ffmpeg >/dev/null 2>&1; then
    echo "FFmpeg installed successfully!"
else
    echo "Failed to install FFmpeg!"
    exit 1
fi

# Install ImageMagick
echo "Installing ImageMagick..."
sudo apt install -y imagemagick

# Verify ImageMagick installation
if command -v convert >/dev/null 2>&1; then
    echo "ImageMagick installed successfully!"
else
    echo "Failed to install ImageMagick!"
    exit 1
fi

# Install Ghostscript
echo "Installing Ghostscript..."
sudo apt install -y ghostscript

# Verify Ghostscript installation
if command -v gs >/dev/null 2>&1; then
    echo "Ghostscript installed successfully!"
else
    echo "Failed to install Ghostscript!"
    exit 1
fi

# Clean up
echo "Cleaning up..."
sudo apt autoremove -y

echo "All tools have been installed successfully!"
