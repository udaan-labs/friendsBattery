@echo off
REM Full reset + run (use after API regen / path-package changes).
cd /d "%~dp0frontend"
if %errorlevel% neq 0 (
  echo [ERROR] frontend folder not found.
  exit /b 1
)

echo ==============================================
echo 1. flutter clean
echo ==============================================
call flutter clean
if %errorlevel% neq 0 (
  echo [ERROR] flutter clean failed.
  exit /b %errorlevel%
)

echo.
echo ==============================================
echo 2. flutter pub get
echo ==============================================
call flutter pub get
if %errorlevel% neq 0 (
  echo [ERROR] flutter pub get failed.
  exit /b %errorlevel%
)

echo.
echo ==============================================
echo 3. flutter run
echo ==============================================
REM Extra args pass through, e.g. fresh.bat -d chrome
call flutter run --dart-define=ENV_FILE=.env.local %*
