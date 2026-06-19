@echo off
echo ==============================================
echo 1. Exporting Swagger JSON from Backend...
echo ==============================================
cd backend
call npm run swagger:export
if %errorlevel% neq 0 (
    echo [ERROR] Failed to export swagger JSON.
    cd ..
    pause
    exit /b %errorlevel%
)
cd ..

echo.
echo ==============================================
echo 2. Generating Flutter Models...
echo ==============================================
call npx @openapitools/openapi-generator-cli generate -i ./backend/openapi.json -g dart -o ./frontend/lib/api --additional-properties=pubName=friends_battery_api
if %errorlevel% neq 0 (
    echo [ERROR] Failed to generate Flutter models.
    pause
    exit /b %errorlevel%
)

echo.
echo ==============================================
echo [SUCCESS] API Models Generated Successfully!
echo ==============================================
pause
