@echo off
setlocal enabledelayedexpansion

:: Start the timer
set START_TIME=%TIME%

:: Initialize tool count
set TOOL_COUNT=0

echo Installing required tools...

:: Check if winget is available
where winget >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo Error: Winget is not installed. Please install App Installer from Microsoft Store.
    exit /b 1
)

:: Check and install Python if not present (required for yt-dlp)
where python >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo Installing Python...
    winget install -e --id Python.Python.3.11 --accept-source-agreements --accept-package-agreements
    if %ERRORLEVEL% equ 0 (
        set /a TOOL_COUNT+=1
        :: Add Python to PATH (if not already there)
        setx PATH "%PATH%;%LOCALAPPDATA%\Programs\Python\Python311;%LOCALAPPDATA%\Programs\Python\Python311\Scripts"
    )
) else (
    echo Python is already installed, skipping installation...
)

:: Install FFmpeg
echo Installing FFmpeg...
winget install -e --id Gyan.FFmpeg --accept-source-agreements --accept-package-agreements
if %ERRORLEVEL% equ 0 (
    echo FFmpeg installed successfully!
    set /a TOOL_COUNT+=1
) else (
    echo Failed to install FFmpeg!
    exit /b 1
)

:: Install ImageMagick
echo Installing ImageMagick...
winget install -e --id ImageMagick.ImageMagick --accept-source-agreements --accept-package-agreements
if %ERRORLEVEL% equ 0 (
    echo ImageMagick installed successfully!
    set /a TOOL_COUNT+=1
) else (
    echo Failed to install ImageMagick!
    exit /b 1
)

:: Install Ghostscript
echo Installing Ghostscript...
winget install -e --id ArtifexSoftware.GhostScript --accept-source-agreements --accept-package-agreements
if %ERRORLEVEL% equ 0 (
    echo Ghostscript installed successfully!
    set /a TOOL_COUNT+=1
) else (
    echo Failed to install Ghostscript!
    exit /b 1
)

:: Install yt-dlp using pip
echo Installing yt-dlp...
pip install --upgrade yt-dlp
if %ERRORLEVEL% equ 0 (
    echo yt-dlp installed successfully!
    set /a TOOL_COUNT+=1
) else (
    echo Failed to install yt-dlp!
    exit /b 1
)

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

:: Convert time to seconds for both start and end times
for /f "tokens=1-4 delims=:." %%a in ("%START_TIME%") do (
    set /a "start=(((%%a*60)+1%%b%%100)*60+1%%c%%100)*100+1%%d%%100"
)
for /f "tokens=1-4 delims=:." %%a in ("%END_TIME%") do (
    set /a "end=(((%%a*60)+1%%b%%100)*60+1%%c%%100)*100+1%%d%%100"
)
set /a elapsed=end-start
set /a elapsed_minutes=elapsed/6000
set /a elapsed_seconds=(elapsed%%6000)/100

:: Print summary
echo.
echo All tools have been installed successfully!
echo Total tools installed: %TOOL_COUNT%
echo Script execution time: %elapsed_minutes% minutes and %elapsed_seconds% seconds.

:: Clear screen and show system info
cls
systeminfo | findstr /B /C:"OS Name" /C:"OS Version"

endlocal