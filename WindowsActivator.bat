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

    :: Get OS Caption with error handling
    for /f "tokens=2 delims==" %%i in ('wmic os get Caption /value') do set "os_caption=%%i"
    
    echo Detected OS Caption: "%os_caption%"

    :: Select the KMS key based on OS version
    set "KMS_KEY="
    if "%os_caption%"=="Windows Server 2025 Standard" (
        set "KMS_KEY=TVRH6-WHNXV-R9WG3-9XRFY-MY832"
    ) else if "%os_caption%"=="Windows Server 2025 Datacenter" (
        set "KMS_KEY=D764K-2NDRG-47T6Q-P8T8W-YP6DF"
    ) else if "%os_caption%"=="Windows Server 2025 Datacenter: Azure Edition" (
        set "KMS_KEY=XGN3F-F394H-FD2MY-PP6FD-8MCRC"
    ) else if "%os_caption%"=="Windows Server Standard" (
        set "KMS_KEY=PTXN8-JFHJM-4WC78-MPCBR-9W4KR"
    ) else if "%os_caption%"=="Windows Server Datacenter" (
        set "KMS_KEY=2HXDN-KRXHB-GPYC7-YCKFJ-7FVDG"
    ) else if "%os_caption%"=="Microsoft Windows 10 Pro" (
        set "KMS_KEY=W269N-WFGWX-YVC9B-4J6C9-T83GX"
    ) else if "%os_caption%"=="Microsoft Windows 11 Pro" (
        set "KMS_KEY=W269N-WFGWX-YVC9B-4J6C9-T83GX"
    ) else if "%os_caption%"=="Windows 10 Pro N" (
        set "KMS_KEY=MH37W-N47XK-V7XM9-C7227-GCQG9"
    ) else if "%os_caption%"=="Windows 11 Pro N" (
        set "KMS_KEY=MH37W-N47XK-V7XM9-C7227-GCQG9"
    ) else if "%os_caption%"=="Windows 10 Enterprise" (
        set "KMS_KEY=NPPR9-FWDCX-D2C8J-H872K-2YT43"
    ) else if "%os_caption%"=="Windows 11 Enterprise" (
        set "KMS_KEY=NPPR9-FWDCX-D2C8J-H872K-2YT43"
    ) else if "%os_caption%"=="Windows 10 Enterprise N" (
        set "KMS_KEY=DPH2V-TTNVB-4X9Q3-TJR4H-KHJW4"
    ) else if "%os_caption%"=="Windows 11 Enterprise N" (
        set "KMS_KEY=DPH2V-TTNVB-4X9Q3-TJR4H-KHJW4"
    ) else if "%os_caption%"=="Windows 10 Education" (
        set "KMS_KEY=NW6C2-QMPVW-D7KKK-3GKT6-VCFB2"
    ) else if "%os_caption%"=="Windows 11 Education" (
        set "KMS_KEY=NW6C2-QMPVW-D7KKK-3GKT6-VCFB2"
    ) else if "%os_caption%"=="Windows 10 Pro Education" (
        set "KMS_KEY=6TP4R-GNPTD-KYYHQ-7B7DP-J447Y"
    ) else if "%os_caption%"=="Windows 11 Pro Education" (
        set "KMS_KEY=6TP4R-GNPTD-KYYHQ-7B7DP-J447Y
    ) else if "%os_caption%"=="Windows 10 Enterprise LTSC 2021" (
        set "KMS_KEY=M7XTQ-FN8P6-TTKYV-9D4CC-J462D"
    ) else if "%os_caption%"=="Windows 10 Enterprise LTSC 2019" (
        set "KMS_KEY=M7XTQ-FN8P6-TTKYV-9D4CC-J462D"
    ) else if "%os_caption%"=="Windows 10 Enterprise N LTSC 2021" (
        set "KMS_KEY=92NFX-8DJQP-P6BBQ-THF9C-7CG2H"
    ) else if "%os_caption%"=="Windows 10 Enterprise N LTSC 2019" (
        set "KMS_KEY=92NFX-8DJQP-P6BBQ-THF9C-7CG2H"
    )

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
