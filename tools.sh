#!/bin/bash

# Update package list
echo "Updating package list..."
sudo apt update

# Install essential tools
echo "Installing essential tools..."
sudo apt install -y \
    build-essential \  # Essential compilation tools
    git \               # Version control system
    curl \              # Command line tool for transferring data
    wget \              # Network downloader
    vim \               # Text editor
    nano \              # Another text editor
    htop \              # Interactive process viewer
    tree \              # Directory listing command
    net-tools \         # Networking tools
    iputils-ping \      # Ping command
    unzip \             # Unzip files
    zip \               # Zip files
    tmux \              # Terminal multiplexer
    python3 \          # Python 3
    python3-pip \      # Python package installer
    docker.io \        # Docker container platform
    docker-compose \    # Tool for defining and running multi-container Docker applications
    jq \                # Command-line JSON processor
    rsync \             # File synchronization tool
    gcc \               # GNU Compiler Collection
    make \              # Build automation tool
    neofetch \          # System information tool
    fzf \               # Command-line fuzzy finder
    bat \               # Cat clone with syntax highlighting
    ripgrep \           # Line-oriented search tool
    silversearcher-ag \ # Code searching tool
    exa \               # Modern replacement for 'ls'
    lm-sensors \        # Hardware monitoring
    gparted \           # Partition editor
    snapd               # Snap package manager

# Install curl and speedtest-cli
sudo apt-get install curl && curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash && sudo apt-get install speedtest

# Clean up
echo "Cleaning up..."
sudo apt autoremove -y

echo "All tools have been installed successfully!"
