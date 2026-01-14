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

REM Read credentials from file (skip comment lines starting with #)
REM First non-comment line = username, second non-comment line = password
for /f "eol=# delims=" %%i in (steam_credentials.txt) do (
    if not defined STEAM_USERNAME (
        set "STEAM_USERNAME=%%i"
    ) else if not defined STEAM_PASSWORD (
        set "STEAM_PASSWORD=%%i"
    )
)

REM Validate that template placeholders have been replaced
echo %STEAM_USERNAME% | findstr /C:"your_steam_username_here" >nul && (
    echo ERROR: Please edit steam_credentials.txt with your actual Steam username
    echo The file still contains template placeholder text
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