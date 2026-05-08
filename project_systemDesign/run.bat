@echo off
setlocal
cd /d "%~dp0"
set "PROJECT=%~dp0"
set "PORT=8080"

if exist "C:\Program Files\IIS Express\iisexpress.exe" (
    set "IISEXPRESS=C:\Program Files\IIS Express\iisexpress.exe"
) else if exist "C:\Program Files (x86)\IIS Express\iisexpress.exe" (
    set "IISEXPRESS=C:\Program Files (x86)\IIS Express\iisexpress.exe"
) else (
    echo IIS Express was not found.
    echo Install IIS Express or open the project in Visual Studio.
    pause
    exit /b 1
)

echo Starting MentorHub on http://localhost:%PORT%/
start "" "http://localhost:%PORT%/index.html"
"%IISEXPRESS%" /path:"%PROJECT%" /port:%PORT%
pause
