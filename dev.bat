@echo off
REM Start Express backend with nodemon in a separate window
start "FriendsBattery Backend" cmd /k "cd /d %~dp0backend && npm run dev"

REM Run Flutter app in current terminal so interactive hot-reload (r / R) works
cd /d "%~dp0frontend"
if %errorlevel% neq 0 (
  echo [ERROR] frontend folder not found.
  exit /b 1
)

echo Starting Flutter app with local environment...
flutter run --dart-define=ENV_FILE=.env.local %*
