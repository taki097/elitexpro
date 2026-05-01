# ===== ADMIN CHECK =====
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltinRole] "Administrator")) {
    Write-Host "Run as Administrator!" -ForegroundColor Red
    Pause
    exit
}

# ===== UI =====
function UI {
    Clear-Host
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host "     ELITEX FF OPTIMIZER PRO v4"
    Write-Host "===================================" -ForegroundColor Cyan
}

# ===== DETECT EMULATOR =====
function Get-Emulator {
    return Get-Process -ErrorAction SilentlyContinue | Where-Object {
        $_.ProcessName -match "HD-Player|BlueStacks|Nox|LDPlayer|Android"
    }
}

# ===== BOOST =====
function Boost {
    UI
    Write-Host "Detecting Emulator..." -ForegroundColor Yellow

    $emu = Get-Emulator

    if ($emu) {
        foreach ($p in $emu) {
            try {
                $p.PriorityClass = "High"
                Write-Host "$($p.ProcessName) => Boosted" -ForegroundColor Green
            } catch {}
        }
    } else {
        Write-Host "No Emulator Running!" -ForegroundColor Red
    }

    # Network latency tweak (safe)
    ipconfig /flushdns | Out-Null

    Write-Host "Boost Applied!" -ForegroundColor Green
    Pause
}

# ===== CLEAN =====
function Clean {
    UI
    Write-Host "Cleaning Background Apps..." -ForegroundColor Yellow

    $apps = "OneDrive","YourPhone","Teams"
    foreach ($a in $apps) {
        Stop-Process -Name $a -Force -ErrorAction SilentlyContinue
    }

    Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue

    Write-Host "Clean Done!" -ForegroundColor Green
    Pause
}

# ===== GAME MODE =====
function GameMode {
    UI
    Write-Host "Activating Gaming Mode..." -ForegroundColor Yellow

    powercfg -setactive SCHEME_MIN

    reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f | Out-Null

    Boost

    Write-Host "Gaming Mode ON" -ForegroundColor Green
    Pause
}

# ===== EXTREME (SAFE VERSION) =====
function Extreme {
    UI
    Write-Host "EXTREME MODE (SAFE)" -ForegroundColor Red

    Stop-Process OneDrive -Force -ErrorAction SilentlyContinue
    Stop-Process Teams -Force -ErrorAction SilentlyContinue

    powercfg -setactive SCHEME_MIN

    Boost

    Write-Host "Extreme Boost Done!" -ForegroundColor Green
    Pause
}

# ===== RESTORE =====
function Restore {
    UI
    powercfg -setactive SCHEME_BALANCED

    Write-Host "Normal Mode Restored!" -ForegroundColor Green
    Pause
}

# ===== MENU =====
while ($true) {
    UI

    Write-Host "1. Boost Emulator"
    Write-Host "2. Clean System"
    Write-Host "3. Gaming Mode"
    Write-Host "4. EXTREME Mode"
    Write-Host "5. Restore Normal"
    Write-Host "6. Exit"

    $c = Read-Host "Select"

    switch ($c) {
        "1" { Boost }
        "2" { Clean }
        "3" { GameMode }
        "4" { Extreme }
        "5" { Restore }
        "6" { break }
    }
}
