@echo off
setlocal EnableExtensions
set "PATH=%USERPROFILE%\.shorebird\bin;%PATH%"

where shorebird >nul 2>&1
if errorlevel 1 (
  echo [ERROR] Shorebird CLI nahi mila.
  echo Install: irm https://shorebird.dev/install.ps1 ^| iex
  echo Phir naya terminal kholo.
  exit /b 1
)

cd /d "%~dp0frontend"
if errorlevel 1 (
  echo [ERROR] frontend folder nahi mila.
  exit /b 1
)

set "ACTION=%~1"
set "ENV=%~2"

if /i "%ACTION%"=="release" goto check_env
if /i "%ACTION%"=="patch" goto check_env

echo Usage:
echo   shorebird.bat release prod ^| shorebird.bat release dev
echo   shorebird.bat patch prod   ^| shorebird.bat patch dev
echo.
echo Or:
echo   npm run shorebird:release:prod
echo   npm run shorebird:release:dev
echo   npm run shorebird:patch:prod
echo   npm run shorebird:patch:dev
exit /b 1

:check_env
if /i "%ENV%"=="prod" goto set_prod
if /i "%ENV%"=="dev" goto set_dev
echo [ERROR] Env missing. Use: prod ya dev
echo Example: shorebird.bat %ACTION% prod
exit /b 1

:set_prod
set "ENV_FILE=.env.production"
set "YAML_SRC=shorebird.prod.yaml"
set "ENV_LABEL=PROD"
goto apply_yaml

:set_dev
set "ENV_FILE=.env.local"
set "YAML_SRC=shorebird.dev.yaml"
set "ENV_LABEL=DEV"
goto apply_yaml

:apply_yaml
if not exist "%YAML_SRC%" (
  echo [ERROR] %YAML_SRC% nahi mila.
  exit /b 1
)
copy /Y "%YAML_SRC%" shorebird.yaml >nul
if errorlevel 1 (
  echo [ERROR] shorebird.yaml copy fail.
  exit /b 1
)

if /i "%ACTION%"=="release" goto release
if /i "%ACTION%"=="patch" goto patch
exit /b 1

:release
call :pin_shorebird_sdk
if errorlevel 1 exit /b 1
echo ==============================================
echo Shorebird RELEASE android ^(%ENV_LABEL%^)
echo ENV_FILE=%ENV_FILE%
echo app yaml=%YAML_SRC%
echo ==============================================
shorebird release android --artifact apk -- --dart-define=ENV_FILE=%ENV_FILE%
exit /b %errorlevel%

:patch
call :pin_shorebird_sdk
if errorlevel 1 exit /b 1
echo ==============================================
echo Shorebird PATCH android ^(%ENV_LABEL%^)
echo ENV_FILE=%ENV_FILE%
echo app yaml=%YAML_SRC%
echo ==============================================
shorebird patch android -- --dart-define=ENV_FILE=%ENV_FILE%
exit /b %errorlevel%

:pin_shorebird_sdk
REM Gradle loads Flutter from android\local.properties. If that still points
REM at the system Flutter 3.35 SDK, it compiles Shorebird's 3.47 framework
REM and fails with: Undefined name 'Tristate'.
for /f "tokens=5" %%R in ('shorebird --version ^| findstr /B /C:"Flutter "') do set "SB_REV=%%R"
if not defined SB_REV (
  echo [ERROR] Could not read the Shorebird Flutter revision.
  exit /b 1
)
set "SB_FLUTTER=%USERPROFILE%\.shorebird\bin\cache\flutter\%SB_REV%"
if not exist "%SB_FLUTTER%\bin\flutter.bat" (
  echo [ERROR] Shorebird Flutter not found: %SB_FLUTTER%
  echo Run: shorebird upgrade
  exit /b 1
)
if exist ".dart_tool\version" del /f /q ".dart_tool\version"
powershell -NoProfile -Command "$sdk=$env:SB_FLUTTER.Replace('\','\\'); $p='android\local.properties'; $lines=@(Get-Content $p | ForEach-Object { if ($_ -like 'flutter.sdk=*') { 'flutter.sdk=' + $sdk } else { $_ } }); if (-not ($lines -match '^flutter\.sdk=')) { $lines += 'flutter.sdk=' + $sdk }; Set-Content -Path $p -Value $lines -Encoding ascii"
if errorlevel 1 exit /b 1
if exist "android\gradlew.bat" call android\gradlew.bat --stop >nul 2>&1
exit /b 0
