@echo off
set "DOWNLOAD_DIR=%~dp0downloads"
if not exist "%DOWNLOAD_DIR%" mkdir "%DOWNLOAD_DIR%"

set "DATA_DIR=%USERPROFILE%\.gemini\browser_profile"
if not "%~1"=="" set "DATA_DIR=%USERPROFILE%\.gemini\browser_profile_%~1"

set "TARGET_URL=%~2"
if "%TARGET_URL%"=="" set "TARGET_URL=https://www.google.com"

echo Starting Chromium with remote debugging on port 9222...
start "" "C:\Users\kustash01\Downloads\chrome-win\chrome-win\chrome.exe" --remote-debugging-port=9222 --user-data-dir="%DATA_DIR%" "%TARGET_URL%"
