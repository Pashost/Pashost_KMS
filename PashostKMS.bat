@echo off
:: Check if the script is running with administrator privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process cmd -ArgumentList '/c, %~s0' -Verb RunAs"
    exit /b
)

:: Disable command prompt output (for cleaner execution)
echo off
cls

:: Prompt user to select the version they want to activate
echo Please select the version to activate:
echo 1. Windows 10/11 Pro
echo 2. Windows 10/11 Home
set /p choice="Enter the number of your choice (1 or 2): "

:: Assign KMS keys based on user input
if "%choice%"=="1" (
    set "KMS_KEY=W269N-WFGWX-YVC9B-4J6C9-T83GX"
) else if "%choice%"=="2" (
    set "KMS_KEY=TX9XD-98N7V-6WMQ6-BX7FG-H8Q99"
) else (
    echo Invalid choice. Exiting...
    exit /b
)

:: Check Windows activation status quietly
wmic path SoftwareLicensingProduct where "PartialProductKey is not null" get LicenseStatus /value | findstr /C:"LicenseStatus=1" >nul
if %errorlevel%==0 (
    echo Windows is already activated.
    exit /b
)

:: Get OS Caption silently
for /f "tokens=2 delims==" %%i in ('wmic os get Caption /value') do set "os_caption=%%i"
echo Activating Windows for: %os_caption%

:: Run activation commands silently (Suppressing Windows Script Host Dialog)
if defined KMS_KEY (
    echo Activating with KMS key: %KMS_KEY%
    slmgr /ipk %KMS_KEY% >nul 2>&1
    if errorlevel 1 (
        echo Failed to install KMS key. Exiting...
        exit /b
    )

    slmgr /skms kms.digiboy.ir >nul 2>&1
    if errorlevel 1 (
        echo Failed to set KMS server. Exiting...
        exit /b
    )

    slmgr /ato >nul 2>&1
    if errorlevel 1 (
        echo Activation failed. Exiting...
        exit /b
    )

    echo Windows activated successfully.
)

:: Exit silently
exit
