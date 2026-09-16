@echo off
echo Registering AgentChromium task in Windows Task Scheduler...
schtasks /create /tn "AgentChromium" /tr "\"%~dp0start_browser.bat\"" /sc once /st 23:59 /it /f
if %ERRORLEVEL% EQU 0 (
    echo [SUCCESS] Task "AgentChromium" successfully registered!
) else (
    echo [ERROR] Failed to register task. Please run as Administrator.
)
pause
