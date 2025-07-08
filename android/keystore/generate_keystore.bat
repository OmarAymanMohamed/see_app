@echo off
echo SEE App - Android Release Keystore Generator
echo =============================================
echo.

REM Set default values
set KEYSTORE_PATH=release-keystore.jks
set KEY_ALIAS=upload
set VALIDITY=10000

echo This script will generate a keystore for signing release builds.
echo.

REM Prompt for keystore password
set /p KEYSTORE_PASSWORD="Enter keystore password: "
if "%KEYSTORE_PASSWORD%"=="" (
    echo Keystore password cannot be empty.
    exit /b 1
)

REM Prompt for key password (or use same as keystore)
set /p KEY_PASSWORD="Enter key password (press Enter to use same as keystore password): "
if "%KEY_PASSWORD%"=="" (
    set KEY_PASSWORD=%KEYSTORE_PASSWORD%
    echo Using keystore password for key password.
)

REM Prompt for your name and organization
set /p YOUR_NAME="Enter your name (CN): "
if "%YOUR_NAME%"=="" (
    set YOUR_NAME="SEE App Developer"
)

set /p ORGANIZATION="Enter your organization (O): "
if "%ORGANIZATION%"=="" (
    set ORGANIZATION="SEE App"
)

REM Generate the keystore
echo.
echo Generating keystore...
echo.

keytool -genkeypair ^
    -alias %KEY_ALIAS% ^
    -keyalg RSA ^
    -keysize 2048 ^
    -validity %VALIDITY% ^
    -keystore %KEYSTORE_PATH% ^
    -storepass %KEYSTORE_PASSWORD% ^
    -keypass %KEY_PASSWORD% ^
    -dname "CN=%YOUR_NAME%, OU=Development, O=%ORGANIZATION%, L=Unknown, ST=Unknown, C=US"

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo Failed to generate keystore. Make sure you have the Java keytool in your PATH.
    exit /b 1
)

echo.
echo Keystore generated successfully at: %CD%\%KEYSTORE_PATH%
echo.
echo Key details:
echo   - Keystore path: %KEYSTORE_PATH%
echo   - Key alias: %KEY_ALIAS%
echo   - Validity: %VALIDITY% days
echo.
echo For CI/CD, set these environment variables:
echo   - KEYSTORE_PASSWORD=%KEYSTORE_PASSWORD%
echo   - KEY_ALIAS=%KEY_ALIAS%
echo   - KEY_PASSWORD=%KEY_PASSWORD%
echo.
echo IMPORTANT: Keep this keystore and passwords secure. If lost, you won't be able to update your app.
echo.

REM Print SHA-1 and SHA-256 fingerprints for Firebase
echo Keystore SHA-1 fingerprint (for Firebase):
keytool -list -v -keystore %KEYSTORE_PATH% -alias %KEY_ALIAS% -storepass %KEYSTORE_PASSWORD% | findstr SHA1

echo.
echo Keystore SHA-256 fingerprint:
keytool -list -v -keystore %KEYSTORE_PATH% -alias %KEY_ALIAS% -storepass %KEYSTORE_PASSWORD% | findstr SHA256

echo.
echo Remember to add these fingerprints to your Firebase project!