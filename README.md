# Tools Installation Guide

## For Linux Users

To install the tools on Linux, run the following command:

```bash
sudo wget https://raw.githubusercontent.com/codebyhasan/tools/main/tools.sh && sudo chmod +x tools.sh && sudo ./tools.sh
```

This will:
1. Download the installation script
2. Make it executable
3. Run the script to install all required tools

## For Windows Users

To install the tools on Windows, run the following command in PowerShell:

```powershell
wget https://raw.githubusercontent.com/codebyhasan/tools/main/tools.bat -OutFile tools.bat; .\tools.bat
```

### What Gets Installed

#### Linux (tools.sh)
- FFmpeg
- ImageMagick
- Ghostscript
- yt-dlp
- neofetch
- speedtest-cli
- nano

#### Windows (tools.bat)
- FFmpeg
- ImageMagick
- Ghostscript
- yt-dlp

Both scripts will automatically configure the installed tools and set up the necessary environment variables.
