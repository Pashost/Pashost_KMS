@echo off
:: Display Windows version and edition information
echo Displaying Windows Version Information...
wmic os get Caption, Version /value
if %errorlevel% neq 0 (
    echo Error: Failed to retrieve Windows version information.
    pause
    goto :EOF
)

echo.
:: Check Windows activation status
echo Checking Activation Status...
wmic path SoftwareLicensingProduct where "PartialProductKey is not null" get LicenseStatus /value | findstr /C:"LicenseStatus=1" >nul
if %errorlevel%==0 (
    echo Windows is Activated.
    pause
    goto :EOF
) else (
    echo Windows is Not Activated.
)

:: Attempt to get OS caption and set it to variable
for /f "tokens=2 delims==" %%i in ('wmic os get Caption /value') do (
    set "os_caption=%%i"
)
echo Detected OS Caption: "%os_caption%"

:: Verify os_caption was set correctly
if not defined os_caption (
    echo Error: OS caption could not be retrieved or is empty.
    pause
    goto :EOF
)

:: Set KMS key based on os_caption
set "KMS_KEY="
if "%os_caption%"=="Windows Server 2025 Standard" (
    set "KMS_KEY=TVRH6-WHNXV-R9WG3-9XRFY-MY832"
) else if "%os_caption%"=="Microsoft Windows 10 Pro" (
    set "KMS_KEY=W269N-WFGWX-YVC9B-4J6C9-T83GX"
) else if "%os_caption%"=="Windows 11 Enterprise" (
    set "KMS_KEY=NPPR9-FWDCX-D2C8J-H872K-2YT43"
) else (
    echo Unsupported Windows version for activation.
    pause
    goto :EOF
)

:: Confirm KMS key is set
if not defined KMS_KEY (
    echo Error: KMS key could not be determined.
    pause
    goto :EOF
)

echo Setting KMS key to: %KMS_KEY%
slmgr /ipk %KMS_KEY%
timeout /t 5
slmgr /skms kms.digiboy.ir
timeout /t 5
slmgr /ato
echo Activation attempt completed.

:: Pause to keep the batch file window open
pause
