<#
.SYNOPSIS
    Advanced Windows & Office Genuine Activation Verification Tool
.DESCRIPTION
    Checks Windows and Microsoft Office licensing channels (Retail, OEM, Volume/KMS),
    partial product keys, and activation status in a clean, color-coded table.
.LINK
    https://licensemart.com.bd
#>

$Host.UI.RawUI.WindowTitle = "Windows & Office Activation Verifier - LicenseMart BD"
Clear-Host

# Banner
Write-Host "==============================================================================" -ForegroundColor Cyan
Write-Host "          WINDOWS & OFFICE GENUINE ACTIVATION VERIFICATION TOOL               " -ForegroundColor White
Write-Host "               Powered by LicenseMart BD (licensemart.com.bd)                 " -ForegroundColor DarkGray
Write-Host "==============================================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "[*] Scanning system licensing database... Please wait." -ForegroundColor Yellow
Write-Host ""

# Map LicenseStatus integer to readable text
function Get-StatusText($status) {
    switch ($status) {
        0 { return "Unlicensed" }
        1 { return "Licensed (Active)" }
        2 { return "OOB Grace Period" }
        3 { return "OOT Grace Period" }
        4 { return "Non-Genuine Grace" }
        5 { return "Notification Mode" }
        6 { return "Extended Grace" }
        default { return "Unknown ($status)" }
    }
}

# Detect Channel Type from Description
function Get-ChannelType($desc) {
    if ($desc -match "RETAIL") { return "Retail (Genuine)" }
    elseif ($desc -match "OEM") { return "OEM (Genuine)" }
    elseif ($desc -match "VOLUME_KMSCLIENT") { return "Volume (KMS - Temporary)" }
    elseif ($desc -match "VOLUME_MAK") { return "Volume (MAK)" }
    else { return "Other / Custom" }
}

# Query all installed products with a PartialProductKey
$products = Get-CimInstance -ClassName SoftwareLicensingProduct | Where-Object { $_.PartialProductKey }

$results = @()

foreach ($item in $products) {
    $category = if ($item.Name -match "Windows") { "Windows OS" } elseif ($item.Name -match "Office") { "MS Office" } else { "Other" }
    $channel  = Get-ChannelType $item.Description
    $status   = Get-StatusText $item.LicenseStatus
    $expiry   = if ($item.GracePeriodRemaining -eq 0 -and $item.LicenseStatus -eq 1) {
                    "Permanent (Lifetime)"
                } elseif ($item.GracePeriodRemaining -gt 0) {
                    "$([math]::Round($item.GracePeriodRemaining / 1440)) Days Remaining"
                } else {
                    "N/A"
                }

    $results += [PSCustomObject]@{
        Category    = $category
        Product     = ($item.Name -replace ",.*", "").Trim()
        Channel     = $channel
        PartialKey  = "XXXXX-$($item.PartialProductKey)"
        Status      = $status
        Expiration  = $expiry
    }
}

if ($results.Count -eq 0) {
    Write-Host "[!] No active Windows or Office product keys found." -ForegroundColor Red
} else {
    # Print Formatted Table
    $results | Format-Table -AutoSize

    # Color-Coded Security & Authenticity Summary
    Write-Host "------------------------------------------------------------------------------" -ForegroundColor DarkGray
    Write-Host "AUTHENTICITY ANALYSIS:" -ForegroundColor White
    foreach ($res in $results) {
        if ($res.Channel -match "Retail|OEM" -and $res.Status -eq "Licensed (Active)") {
            Write-Host " [OK] $($res.Product) -> Genuine $($res.Channel) | $($res.Expiration)" -ForegroundColor Green
        } elseif ($res.Channel -match "KMS") {
            Write-Host " [WARNING] $($res.Product) -> Running on KMS/Volume ($($res.Expiration)). Likely non-genuine/corporate." -ForegroundColor Red
        } else {
            Write-Host " [INFO] $($res.Product) -> $($res.Channel) | Status: $($res.Status)" -ForegroundColor Yellow
        }
    }
}

Write-Host ""
Write-Host "==============================================================================" -ForegroundColor Cyan
Write-Host " Need a 100% Genuine Lifetime Retail Key in Bangladesh?" -ForegroundColor White
Write-Host " Visit: https://licensemart.com.bd" -ForegroundColor Green
Write-Host "==============================================================================" -ForegroundColor Cyan
Write-Host ""
Read-Host "Press Enter to exit"