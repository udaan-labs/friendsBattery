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
call npx @openapitools/openapi-generator-cli generate -i ./backend/openapi.json -g dart-dio -o ./frontend/lib/api --additional-properties=pubName=friends_battery_api
if %errorlevel% neq 0 (
    echo [ERROR] Failed to generate Flutter models.
    pause
    exit /b %errorlevel%
)

echo.
echo ==============================================
echo 3. Fixing SDK Constraint in pubspec.yaml...
echo ==============================================
powershell -Command "(Get-Content .\frontend\lib\api\pubspec.yaml) -replace 'sdk: ''>=2.18.0 <4.0.0''', 'sdk: ''>=3.9.2 <4.0.0''' | Set-Content .\frontend\lib\api\pubspec.yaml"

echo.
echo ==============================================
echo 4. Running build_runner for API Models...
echo ==============================================
cd frontend\lib\api
call dart pub get
call dart run build_runner build --delete-conflicting-outputs
if %errorlevel% neq 0 (
    echo [ERROR] Failed to run build_runner.
    cd ..\..\..
    pause
    exit /b %errorlevel%
)
cd ..\..\..

echo.
echo ==============================================
echo [SUCCESS] API Models Generated and Built Successfully!
echo ==============================================
pause
