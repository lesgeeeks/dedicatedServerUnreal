@echo off
REM Steam Upload Script for Client Development Build
REM 
REM This script uploads the client build to Steam using SteamCMD
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

REM Validate that credentials were read successfully
if not defined STEAM_USERNAME (
    echo ERROR: Could not read username from steam_credentials.txt
    echo.
    echo Please ensure the file contains at least one non-comment line with your Steam username
    echo Lines starting with # are treated as comments and ignored
    pause
    exit /b 1
)

REM Validate that template placeholders have been replaced
echo %STEAM_USERNAME% | findstr /C:"your_steam_username_here" >nul && (
    echo ERROR: Please edit steam_credentials.txt with your actual Steam username
    echo The file still contains template placeholder text
    pause
    exit /b 1
)

echo Uploading client build to Steam...
echo Username: %STEAM_USERNAME%
echo.

REM Check if password looks like placeholder text (safer check without echoing password)
set "PASSWORD_IS_PLACEHOLDER=0"
if "%STEAM_PASSWORD%"=="your_steam_password_here" set "PASSWORD_IS_PLACEHOLDER=1"
if not defined STEAM_PASSWORD set "PASSWORD_IS_PLACEHOLDER=1"

if "%PASSWORD_IS_PLACEHOLDER%"=="1" (
    REM No password stored - use interactive login
    echo Password not set in credentials file - SteamCMD will prompt for it
    echo.
    builder\steamcmd.exe +login %STEAM_USERNAME% +run_app_build ..\scripts\client_app_build.vdf +quit
) else (
    REM Password is set - create temporary config file for secure password passing
    REM This avoids exposing password in command line arguments or process lists
    REM Note: The temp file is created with restricted permissions and deleted immediately after use
    
    REM Create temp file with restricted access (only current user can read)
    echo @ShutdownOnFailedCommand 1 > temp_steam_config.txt
    echo @NoPromptForPassword 1 >> temp_steam_config.txt
    echo login %STEAM_USERNAME% %STEAM_PASSWORD% >> temp_steam_config.txt
    echo run_app_build ..\scripts\client_app_build.vdf >> temp_steam_config.txt
    echo quit >> temp_steam_config.txt
    
    REM Restrict file permissions to current user only (Windows)
    icacls temp_steam_config.txt /inheritance:r /grant:r "%USERNAME%:F" >nul 2>&1
    
    echo Using stored password from credentials file
    echo.
    echo SECURITY NOTE: Password is passed via temporary script file, not command line
    echo.
    
    builder\steamcmd.exe +runscript temp_steam_config.txt
    
    REM Clean up temporary config file immediately
    if exist temp_steam_config.txt (
        del temp_steam_config.txt
        if exist temp_steam_config.txt (
            echo WARNING: Failed to delete temporary config file
            echo Please manually delete temp_steam_config.txt
        )
    )
)

echo.
echo Upload complete!
pause