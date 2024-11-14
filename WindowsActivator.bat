@echo off
:: Check if the script is running with administrator privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script requires administrator privileges. Re-running as administrator...
    :: Re-launch the script with administrator privileges
    powershell -Command "Start-Process cmd -ArgumentList '/c, %~s0' -Verb RunAs"
    exit /b
)

:: Display Windows version and edition information
echo Windows Version Information:
wmic os get Caption, Version /value
echo.

:: Prompt user to select the version they want to activate
echo Please select the version to activate:
echo 1. Windows 10 Pro
echo 2. Windows 10 Home
set /p choice="Enter the number of your choice (1 or 2): "

:: Assign KMS keys based on user input
if "%choice%"=="1" (
    set "KMS_KEY=W269N-WFGWX-YVC9B-4J6C9-T83GX"
    echo You selected Windows 10 Pro.
) else if "%choice%"=="2" (
    set "KMS_KEY=TX9XD-98N7V-6WMQ6-BX7FG-H8Q99"
    echo You selected Windows 10 Home.
) else (
    echo Invalid choice. Exiting...
    exit /b
)

:: Check Windows activation status
echo Checking Activation Status...
wmic path SoftwareLicensingProduct where "PartialProductKey is not null" get LicenseStatus /value | findstr /C:"LicenseStatus=1" >nul

if %errorlevel%==0 (
    echo Windows is Activated
) else (
    echo Windows is Not Activated
    echo.
    echo Attempting to activate Windows...

    :: Get OS Caption with error handling
    echo Retrieving OS Caption...
    for /f "tokens=2 delims==" %%i in ('wmic os get Caption /value') do (
        set "os_caption=%%i"
        echo OS Caption Retrieved: %%i
    )

    :: Check if os_caption is set
    if not defined os_caption (
        echo Error: Failed to retrieve OS Caption.
        goto :eof
    )

    echo Detected OS Caption: "%os_caption%"

    :: Run activation commands if KMS key is defined
    if defined KMS_KEY (
        echo Setting KMS key to: %KMS_KEY%
        slmgr /ipk %KMS_KEY%
        timeout /t 5
        slmgr /skms kms.digiboy.ir
        timeout /t 5
        slmgr /ato
        echo Activation attempt completed.
    ) else (
        echo Unsupported Windows version for activation.
    )
)

:: Pause to keep the batch file window open
pause
