@echo off
echo ===== Flutter Installation Script =====
echo This script will download and set up Flutter SDK
echo.

set FLUTTER_DIR=%USERPROFILE%\flutter
echo Flutter will be installed to: %FLUTTER_DIR%
echo.

REM Create directory if it doesn't exist
if not exist "%FLUTTER_DIR%" mkdir "%FLUTTER_DIR%"

echo Downloading Flutter SDK...
curl -SL "https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.19.3-stable.zip" -o %TEMP%\flutter.zip

echo Extracting Flutter SDK...
powershell -Command "Expand-Archive -Force '%TEMP%\flutter.zip' -DestinationPath '%USERPROFILE%'"

echo Setting up environment variables...
echo Adding Flutter to PATH...
setx PATH "%PATH%;%FLUTTER_DIR%\bin" /M

echo.
echo Flutter installation completed!
echo.
echo Please restart your terminal and run 'flutter doctor' to verify the installation.
echo.
echo If Flutter is not recognized after restarting, you may need to manually add
echo %FLUTTER_DIR%\bin to your PATH environment variable.
echo.
echo ===== Installation Complete =====
pause