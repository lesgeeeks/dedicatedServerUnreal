@echo off
REM Steam Upload Script for Server Development Build
REM 
REM This script uploads the server build to Steam using SteamCMD
REM 
REM REQUIRED SETUP:
REM 1. Copy steam_credentials.template to steam_credentials.txt
REM 2. Edit steam_credentials.txt with your Steam credentials
REM 3. DO NOT commit steam_credentials.txt (it's in .gitignore)
REM
REM For more information, see the "Steam Credentials Setup" section in README.md

REM Check if credentials file exists
if not exist steam_credentials.txt (
    echo ERROR: steam_credentials.txt not found!
    echo.
    echo Please create steam_credentials.txt from the template:
    echo   1. Copy steam_credentials.template to steam_credentials.txt
    echo   2. Edit steam_credentials.txt with your Steam username and password
    echo.
    echo See README.md for detailed setup instructions.
    pause
    exit /b 1
)

REM Read credentials from file (first line = username, second line = password)
set /p STEAM_USERNAME=<steam_credentials.txt
more +1 steam_credentials.txt > temp_cred.txt
set /p STEAM_PASSWORD=<temp_cred.txt
if exist temp_cred.txt del temp_cred.txt

REM Remove comment lines and template placeholders
echo %STEAM_USERNAME% | findstr /C:"#" >nul && (
    echo ERROR: Please edit steam_credentials.txt with your actual Steam username
    echo The file still contains template/comment lines
    pause
    exit /b 1
)

echo Uploading server build to Steam...
echo Username: %STEAM_USERNAME%
echo.

REM If password is empty or contains placeholder text, prompt interactively
echo %STEAM_PASSWORD% | findstr /C:"your_steam_password_here" >nul && (
    echo Password not set in credentials file - SteamCMD will prompt for it
    builder\steamcmd.exe +login %STEAM_USERNAME% +run_app_build ..\scripts\server_app_build.vdf +quit
) || (
    REM Password is set in credentials file
    builder\steamcmd.exe +login %STEAM_USERNAME% %STEAM_PASSWORD% +run_app_build ..\scripts\server_app_build.vdf +quit
)

echo.
echo Upload complete!
pause