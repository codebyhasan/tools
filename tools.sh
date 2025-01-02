#!/bin/bash

# Update package list
echo "Updating package list..."
sudo apt update

# Install essential tools
echo "Installing essential tools..."
sudo apt install -y \
    build-essential \
    git \
    curl \
    wget \
    nano \
    htop \
    tree \
    net-tools \
    iputils-ping \
    unzip \
    zip \
    tmux \
    python3 \
    python3-pip \
    docker.io \
    docker-compose \
    jq \
    rsync \
    gcc \
    make \
    neofetch \
    fzf \
    bat \
    ripgrep \
    silversearcher-ag \
    exa \
    lm-sensors \
    gparted \
    snapd \
    yt-dlp

# Install speedtest-cli
echo "Installing speedtest-cli..."
sudo apt-get install curl && curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash && sudo apt-get install speedtest


# Clean up
echo "Cleaning up..."
sudo apt autoremove -y

echo "All tools have been installed successfully!"
