@echo off
REM Start Express backend with nodemon in a separate window
start "FriendsBattery Backend" cmd /k "cd /d %~dp0backend && npm run dev"

REM Run ngrok tunnel in this terminal so the public URL stays visible
cd /d "%~dp0"
echo Starting ngrok tunnel (backend in other window)...
npm run tunnel %*
