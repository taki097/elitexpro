Clear-Host
$Host.UI.RawUI.WindowTitle = "EliteX Optimizer PRO"

# ===== LOGIN =====
while ($true) {
    Clear-Host
    Write-Host "==============================" -ForegroundColor Cyan
    Write-Host "     EliteX Optimizer PRO"
    Write-Host "==============================" -ForegroundColor Cyan

    $user = Read-Host "Username"
    $pass = Read-Host "Password"

    if ($user -eq "elite" -and $pass -eq "1") {
        Write-Host "Login Success!" -ForegroundColor Green
        Start-Sleep 1
        break
    } else {
        Write-Host "Wrong Login!" -ForegroundColor Red
        Start-Sleep 1
    }
}

# ===== FUNCTIONS =====
function FPS-Boost {
    Write-Host "FPS Boost..." -ForegroundColor Yellow
    Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
    ipconfig /flushdns | Out-Null
    Stop-Service SysMain -Force -ErrorAction SilentlyContinue
    Write-Host "Done!" -ForegroundColor Green
    Pause
}

function Aim-Optimize {
    Write-Host "Aim Optimize..." -ForegroundColor Yellow
    Set-ItemProperty "HKCU:\Control Panel\Mouse" MouseSpeed 0
    Set-ItemProperty "HKCU:\Control Panel\Mouse" MouseThreshold1 0
    Set-ItemProperty "HKCU:\Control Panel\Mouse" MouseThreshold2 0
    Write-Host "Done!" -ForegroundColor Green
    Pause
}

function Clean-System {
    Write-Host "Cleaning..." -ForegroundColor Yellow
    Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "Done!" -ForegroundColor Green
    Pause
}

function Gaming-On {
    FPS-Boost
    Aim-Optimize
    Write-Host "Gaming Mode ON!" -ForegroundColor Green
    Pause
}

function Gaming-Off {
    Start-Service SysMain -ErrorAction SilentlyContinue
    powercfg -setactive SCHEME_BALANCED
    Write-Host "Normal Mode Restored!" -ForegroundColor Green
    Pause
}

function Detect-Boost {
    Write-Host "Detecting Game..." -ForegroundColor Yellow

    $mc = Get-Process javaw -ErrorAction SilentlyContinue
    if ($mc) { $mc.PriorityClass="High"; Write-Host "Minecraft Boosted!" }

    $valo = Get-Process VALORANT-Win64-Shipping -ErrorAction SilentlyContinue
    if ($valo) { $valo.PriorityClass="High"; Write-Host "Valorant Boosted!" }

    Pause
}

function Extreme-Boost {
    Write-Host "EXTREME MODE..." -ForegroundColor Red
    Stop-Process OneDrive -Force -ErrorAction SilentlyContinue
    Stop-Process YourPhone -Force -ErrorAction SilentlyContinue
    Stop-Service SysMain -Force -ErrorAction SilentlyContinue
    powercfg -setactive SCHEME_MIN
    Write-Host "EXTREME DONE!" -ForegroundColor Green
    Pause
}

function Backup {
    reg export "HKCU\Control Panel\Mouse" backup_mouse.reg /y | Out-Null
    Write-Host "Backup Saved!" -ForegroundColor Green
    Pause
}

function Restore {
    if (Test-Path "backup_mouse.reg") { reg import backup_mouse.reg }
    Write-Host "Restored!" -ForegroundColor Green
    Pause
}

function Network-Reset {
    netsh winsock reset | Out-Null
    ipconfig /flushdns | Out-Null
    Write-Host "Network Reset Done!" -ForegroundColor Green
    Pause
}

function Auto-Boost {
    Write-Host "Auto Boost Running... (CTRL+C to stop)" -ForegroundColor Cyan
    while ($true) {
        Start-Sleep 5

        if (Get-Process javaw -ErrorAction SilentlyContinue) { Extreme-Boost }
        if (Get-Process VALORANT-Win64-Shipping -ErrorAction SilentlyContinue) { Extreme-Boost }
    }
}

# ===== MENU LOOP =====
while ($true) {
    Clear-Host
    Write-Host "==============================" -ForegroundColor Green
    Write-Host "     EliteX Optimizer"
    Write-Host "==============================" -ForegroundColor Green

    Write-Host "1. FPS Boost"
    Write-Host "2. Aim Optimize"
    Write-Host "3. Deep Clean"
    Write-Host "4. Gaming Mode ON"
    Write-Host "5. Gaming Mode OFF"
    Write-Host "6. Auto Detect Boost"
    Write-Host "7. EXTREME Boost"
    Write-Host "8. Backup"
    Write-Host "9. Restore"
    Write-Host "10. Network Reset"
    Write-Host "11. Auto Boost Mode"
    Write-Host "12. Exit"

    $c = Read-Host "Select"

    switch ($c) {
        "1" { FPS-Boost }
        "2" { Aim-Optimize }
        "3" { Clean-System }
        "4" { Gaming-On }
        "5" { Gaming-Off }
        "6" { Detect-Boost }
        "7" { Extreme-Boost }
        "8" { Backup }
        "9" { Restore }
        "10" { Network-Reset }
        "11" { Auto-Boost }
        "12" { break }
    }
}