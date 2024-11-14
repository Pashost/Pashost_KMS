@echo off
setlocal enabledelayedexpansion

:: Display Windows version and edition information
echo Windows Version Information:
wmic os get Caption, Version /value

echo.
:: Check Windows activation status
echo Checking Activation Status...
wmic path SoftwareLicensingProduct where "PartialProductKey is not null" get LicenseStatus /value | findstr /C:"LicenseStatus=1" >nul

:: Check if activation status command returned an error (indicating Windows is not activated)
if %errorlevel%==0 (
    :: If Windows is activated
    echo Windows is Activated
) else (
    :: If Windows is not activated
    echo Windows is Not Activated
    echo.
    echo Attempting to activate Windows...

    :: Get the Windows version caption
    set os_caption=""
    for /f "tokens=2 delims==" %%i in ('wmic os get Caption /value') do (
        set os_caption=%%i
        set os_caption=!os_caption: =!
    )

    :: Check if os_caption is empty or undefined
    if "!os_caption!"=="" (
        echo Error: Failed to retrieve Windows version. Exiting...
        exit /b
    )

    :: Debugging: Print the retrieved OS caption
    echo Retrieved OS Caption: !os_caption!

    :: Check for each possible Windows version and assign appropriate KMS key
    if /i "!os_caption!"=="Microsoft Windows 10 Home" (
        set KMS_KEY=TX9XD-98N7V-6WMQ6-BX7FG-H8Q99
    ) else if /i "!os_caption!"=="Microsoft Windows 10 Home N" (
        set KMS_KEY=3KHY7-WNT83-DGQKR-F7HPR-844BM
    ) else if /i "!os_caption!"=="Microsoft Windows 10 Home Single Language" (
        set KMS_KEY=7HNRX-D7KGG-3K4RQ-4WPJ4-YTDFH
    ) else if /i "!os_caption!"=="Microsoft Windows 10 Pro" (
        set KMS_KEY=W269N-WFGWX-YVC9B-4J6C9-T83GX
    ) else if /i "!os_caption!"=="Microsoft Windows 10 Pro N" (
        set KMS_KEY=MH37W-N47XK-V7XM9-C7227-GCQG9
    ) else if /i "!os_caption!"=="Microsoft Windows 10 Pro for Workstations" (
        set KMS_KEY=NRG8B-VKK3Q-CXVCJ-9G2XF-6Q84J
    ) else if /i "!os_caption!"=="Microsoft Windows 10 Pro N for Workstations" (
        set KMS_KEY=9FNHH-K3HBT-3W4TD-6383H-6XYWF
    ) else if /i "!os_caption!"=="Microsoft Windows 10 Education" (
        set KMS_KEY=NW6C2-QMPVW-D7KKK-3GKT6-VCFB2
    ) else if /i "!os_caption!"=="Microsoft Windows 10 Education N" (
        set KMS_KEY=2WH4N-8QGBV-H22JP-CT43Q-MDWWJ
    ) else if /i "!os_caption!"=="Microsoft Windows 10 Pro Education" (
        set KMS_KEY=6TP4R-GNPTD-KYYHQ-7B7DP-J447Y
    ) else if /i "!os_caption!"=="Microsoft Windows 10 Pro Education N" (
        set KMS_KEY=YVWGF-BXNMC-HTQYQ-CPQ99-66QFC
    ) else if /i "!os_caption!"=="Microsoft Windows 10 Enterprise" (
        set KMS_KEY=NPPR9-FWDCX-D2C8J-H872K-2YT43
    ) else if /i "!os_caption!"=="Microsoft Windows 10 Enterprise N" (
        set KMS_KEY=DPH2V-TTNVB-4X9Q3-TJR4H-KHJW4
    ) else if /i "!os_caption!"=="Microsoft Windows 10 Enterprise G" (
        set KMS_KEY=YYVX9-NTFWV-6MDM3-9PT4T-4M68B
    ) else if /i "!os_caption!"=="Microsoft Windows 10 Enterprise G N" (
        set KMS_KEY=44RPN-FTY23-9VTTB-MP9BX-T84FV
    ) else if /i "!os_caption!"=="Microsoft Windows 10 Enterprise LTSC 2016" (
        set KMS_KEY=DCPHK-NFMTC-H88MJ-PFHPY-QJ4BJ
    ) else if /i "!os_caption!"=="Microsoft Windows 10 Enterprise LTSC 2021" (
        set KMS_KEY=M7XTQ-FN8P6-TTKYV-9D4CC-J462D
    ) else if /i "!os_caption!"=="Microsoft Windows 10 Enterprise N LTSC 2021" (
        set KMS_KEY=92NFX-8DJQP-P6BBQ-THF9C-7CG2H
    ) else (
        echo Unsupported Windows version for activation.
        exit /b
    )

    :: Debugging: Print the selected KMS key
    echo Using KMS Key: !KMS_KEY!

    :: Run the activation commands with delays between them
    echo Running activation commands...
    powershell -Command "Start-Process cmd -ArgumentList '/c slmgr /ipk !KMS_KEY! && timeout /t 5 && slmgr /skms kms.digiboy.ir && timeout /t 5 && slmgr /ato && echo Activation commands executed. && pause' -Verb RunAs"

    :: Check for error during activation
    if %errorlevel% neq 0 (
        echo Error: Activation process failed with error code %errorlevel%.
        exit /b
    )
)

:: Pause to keep the batch file window open until the user presses a key
pause
