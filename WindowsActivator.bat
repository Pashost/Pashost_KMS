@echo off
:: Display Windows version and edition information
echo Windows Version Information:
wmic os get Caption, Version /value

echo.
:: Check Windows activation status
echo Checking Activation Status...
wmic path SoftwareLicensingProduct where "PartialProductKey is not null" get LicenseStatus /value | findstr /C:"LicenseStatus=1" >nul

if %errorlevel%==0 (
    echo Windows is Activated
) else (
    echo Windows is Not Activated
    echo.
    echo Attempting to activate Windows...

    for /f "tokens=2 delims==" %%i in ('wmic os get Caption /value') do set os_caption=%%i

    if "%os_caption%"=="Microsoft Windows 10 Pro" (
        set KMS_KEY=W269N-WFGWX-YVC9B-4J6C9-T83GX
    ) else if "%os_caption%"=="Microsoft Windows 11 Pro" (
        set KMS_KEY=W269N-WFGWX-YVC9B-4J6C9-T83GX
    ) else (
        echo Unsupported Windows version for activation.
        goto :EOF
    )

    if defined KMS_KEY (
        slmgr /ipk %KMS_KEY%
        timeout /t 5
        slmgr /skms kms.digiboy.ir
        timeout /t 5
        slmgr /ato
        echo Activation attempt completed.
    )
)

pause
