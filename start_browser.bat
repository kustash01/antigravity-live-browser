@echo off
set "DOWNLOAD_DIR=%~dp0downloads"
if not exist "%DOWNLOAD_DIR%" mkdir "%DOWNLOAD_DIR%"

set "DATA_DIR=%USERPROFILE%\.gemini\browser_profile"
if not "%~1"=="" set "DATA_DIR=%USERPROFILE%\.gemini\browser_profile_%~1"

set "TARGET_URL=%~2"
if "%TARGET_URL%"=="" set "TARGET_URL=https://www.google.com"

echo Starting Chromium with ultra-performance flags on port 9222...
start "" "C:\Users\kustash01\Downloads\chrome-win\chrome-win\chrome.exe" ^
  --remote-debugging-port=9222 ^
  --user-data-dir="%DATA_DIR%" ^
  --disable-background-timer-throttling ^
  --disable-backgrounding-occluded-windows ^
  --disable-renderer-backgrounding ^
  --disable-features=CalculateNativeWinOcclusion,IntensiveWakeUpThrottling,ThrottleDisplayNoneAndVisibilityHiddenCrossOriginIframes ^
  --enable-gpu-rasterization ^
  --enable-zero-copy ^
  --ignore-gpu-blocklist ^
  --disable-component-update ^
  --disable-background-networking ^
  --disable-domain-reliability ^
  --disable-sync ^
  --no-default-browser-check ^
  --no-first-run ^
  "%TARGET_URL%"
