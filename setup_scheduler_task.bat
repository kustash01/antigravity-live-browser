@echo off
echo Registering AgentChromium task in Windows Task Scheduler...
schtasks /create /tn "AgentChromium" /tr "\"%~dp0start_browser.bat\"" /sc once /st 23:59 /it /f
if %ERRORLEVEL% EQU 0 (
    echo [SUCCESS] Task "AgentChromium" successfully registered!
    echo Configuring battery and priority settings...
    powershell -NoProfile -Command "$task = Get-ScheduledTask -TaskName 'AgentChromium'; $task.Settings.DisallowStartIfOnBatteries = $false; $task.Settings.StopIfGoingOnBatteries = $false; $task.Settings.Priority = 4; Set-ScheduledTask -InputObject $task"
    echo [SUCCESS] Task optimized for instant execution and battery operation!
) else (
    echo [ERROR] Failed to register task. Please run as Administrator.
)
pause
