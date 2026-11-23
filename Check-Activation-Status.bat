@echo off
title Windows & Office Genuine Activation Checker - LicenseMart BD
color 0A
cls

echo ============================================================================
echo        WINDOWS ^& OFFICE GENUINE ACTIVATION VERIFICATION TOOL
echo               Powered by LicenseMart Bangladesh (licensemart.com.bd)
echo ============================================================================
echo.
echo [1/3] Checking Windows License Channel (Retail / OEM / Volume)...
echo ----------------------------------------------------------------------------
cscript //nologo %windir%\system32\slmgr.vbs /dli
echo.

echo [2/3] Checking Windows License Expiration Status...
echo ----------------------------------------------------------------------------
cscript //nologo %windir%\system32\slmgr.vbs /xpr
echo.

echo [3/3] Checking Microsoft Office Activation Status...
echo ----------------------------------------------------------------------------
set "officeFound=0"

for %%d in (
    "%ProgramFiles%\Microsoft Office\Office16"
    "%ProgramFiles(x86)%\Microsoft Office\Office16"
    "%ProgramFiles%\Microsoft Office\Office15"
    "%ProgramFiles(x86)%\Microsoft Office\Office15"
) do (
    if exist "%%~d\ospp.vbs" (
        set "officeFound=1"
        echo Found Office installation at: %%~d
        cscript //nologo "%%~d\ospp.vbs" /dstatus | findstr /i "LICENSE NAME LICENSE DESCRIPTION LICENSE STATUS Remaining grace"
    )
)

if "%officeFound%"=="0" (
    echo Microsoft Office (2013/2016/2019/2021/365) installation not detected or using newer C2R licensing.
)

echo.
echo ============================================================================
echo  Need a 100%% Genuine Retail License Key in Bangladesh?
echo  Visit: https://licensemart.com.bd
echo ============================================================================
pause