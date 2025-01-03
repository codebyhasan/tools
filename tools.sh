#!/bin/bash

# Start the timer
START_TIME=$(date +%s)

# Initialize the tool count
TOOL_COUNT=0

# Update package list
echo "Updating package list..."
sudo apt update

# Install essential tools
echo "Installing essential tools..."
sudo apt install -y neofetch && ((TOOL_COUNT++))

# Install speedtest-cli
echo "Installing speedtest-cli..."
sudo apt-get install -y curl && \
    curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash && \
    sudo apt-get install -y speedtest && ((TOOL_COUNT++))

# Install FFmpeg
echo "Installing FFmpeg..."
sudo apt install -y ffmpeg && ((TOOL_COUNT++))

# Verify FFmpeg installation
if command -v ffmpeg >/dev/null 2>&1; then
    echo "FFmpeg installed successfully!"
else
    echo "Failed to install FFmpeg!"
    exit 1
fi

# Install ImageMagick
echo "Installing ImageMagick..."
sudo apt install -y imagemagick && ((TOOL_COUNT++))

# Verify ImageMagick installation
if command -v convert >/dev/null 2>&1; then
    echo "ImageMagick installed successfully!"
else
    echo "Failed to install ImageMagick!"
    exit 1
fi

# Install Ghostscript
echo "Installing Ghostscript..."
sudo apt install -y ghostscript && ((TOOL_COUNT++))

# Verify Ghostscript installation
if command -v gs >/dev/null 2>&1; then
    echo "Ghostscript installed successfully!"
else
    echo "Failed to install Ghostscript!"
    exit 1
fi

# Install yt-dlp
echo "Installing yt-dlp..."
sudo apt install -y python3-pip && \
    sudo pip3 install yt-dlp && ((TOOL_COUNT++))

# Verify yt-dlp installation
if command -v yt-dlp >/dev/null 2>&1; then
    echo "yt-dlp installed successfully!"
else
    echo "Failed to install yt-dlp!"
    exit 1
fi

# Configure yt-dlp to use a default output format and merge files into .mp4
echo "Configuring yt-dlp to default to .mp4 format..."

# Create the configuration directory for yt-dlp if it doesn't exist
mkdir -p ~/.config/yt-dlp

# Set the output format to include the title, platform name, and video ID
echo '--output "%(title)s [%(extractor)s %(id)s].%(ext)s"' >> ~/.config/yt-dlp/config

# Set the merge output format to .mp4
echo '--merge-output-format mp4' >> ~/.config/yt-dlp/config



# Clean up
echo "Cleaning up..."
sudo apt autoremove -y

# End the timer
END_TIME=$(date +%s)
ELAPSED_TIME=$((END_TIME - START_TIME))

# Print summary
echo "All tools have been installed successfully!"
echo "Total tools installed: $TOOL_COUNT"
echo "Script execution time: $((ELAPSED_TIME / 60)) minutes and $((ELAPSED_TIME % 60)) seconds."
