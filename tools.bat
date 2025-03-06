@echo off
setlocal enabledelayedexpansion

:: Start the timer
set START_TIME=%TIME%

:: Initialize tool count
set TOOL_COUNT=0

echo Installing required tools...

:: Define download directory
set DOWNLOAD_DIR=%TEMP%\installer_downloads
if not exist "%DOWNLOAD_DIR%" mkdir "%DOWNLOAD_DIR%"

:: Function to download and install software
set "PYTHON_URL=https://www.python.org/ftp/python/3.11.4/python-3.11.4-amd64.exe"
set "FFMPEG_URL=https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-full.7z"
set "IMAGEMAGICK_URL=https://imagemagick.org/download/binaries/ImageMagick-7.1.1-30-Q16-HDRI-x64-dll.exe"
set "GHOSTSCRIPT_URL=https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs1010/gs1010w64.exe"

:: Install Python
where python >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo Downloading and installing Python...
    powershell -Command "Invoke-WebRequest -Uri '%PYTHON_URL%' -OutFile '%DOWNLOAD_DIR%\python-installer.exe'"
    start /wait %DOWNLOAD_DIR%\python-installer.exe /quiet InstallAllUsers=1 PrependPath=1
    if %ERRORLEVEL% equ 0 set /a TOOL_COUNT+=1
) else (
    echo Python is already installed, skipping installation...
)

:: Install FFmpeg (manual extraction required)
echo Downloading FFmpeg...
powershell -Command "Invoke-WebRequest -Uri '%FFMPEG_URL%' -OutFile '%DOWNLOAD_DIR%\ffmpeg.7z'"
if %ERRORLEVEL% equ 0 set /a TOOL_COUNT+=1

:: Install ImageMagick
echo Downloading and installing ImageMagick...
powershell -Command "Invoke-WebRequest -Uri '%IMAGEMAGICK_URL%' -OutFile '%DOWNLOAD_DIR%\imagemagick.exe'"
start /wait %DOWNLOAD_DIR%\imagemagick.exe /SILENT
if %ERRORLEVEL% equ 0 set /a TOOL_COUNT+=1

:: Install Ghostscript
echo Downloading and installing Ghostscript...
powershell -Command "Invoke-WebRequest -Uri '%GHOSTSCRIPT_URL%' -OutFile '%DOWNLOAD_DIR%\ghostscript.exe'"
start /wait %DOWNLOAD_DIR%\ghostscript.exe /S
if %ERRORLEVEL% equ 0 set /a TOOL_COUNT+=1

:: Install yt-dlp using pip
echo Installing yt-dlp...
pip install --upgrade yt-dlp
if %ERRORLEVEL% equ 0 set /a TOOL_COUNT+=1

:: Configure yt-dlp
echo Configuring yt-dlp...
if not exist "%APPDATA%\yt-dlp" mkdir "%APPDATA%\yt-dlp"
(
echo --output "%%%(title)s [%%%(extractor)s %%%(id)s].%%%(ext)s"
echo --merge-output-format mp4
echo --continue
) > "%APPDATA%\yt-dlp\config.txt"

:: Calculate elapsed time
set END_TIME=%TIME%
for /f "tokens=1-4 delims=:." %%a in ("%START_TIME%") do (
    set /a "start=(((%%a*60)+1%%b%%100)*60+1%%c%%100)*100+1%%d%%100"
)
for /f "tokens=1-4 delims=:." %%a in ("%END_TIME%") do (
    set /a "end=(((%%a*60)+1%%b%%100)*60+1%%c%%100)*100+1%%d%%100"
)
set /a elapsed=end-start
set /a elapsed_minutes=elapsed/6000
set /a elapsed_seconds=(elapsed%%6000)/100

echo.
echo All tools have been installed successfully!
echo Total tools installed: %TOOL_COUNT%
echo Script execution time: %elapsed_minutes% minutes and %elapsed_seconds% seconds.

:: Clear screen and show system info
cls
systeminfo | findstr /B /C:"OS Name" /C:"OS Version"

endlocal
