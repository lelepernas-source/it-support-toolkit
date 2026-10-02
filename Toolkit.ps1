$scriptPath = Join-Path $PSScriptRoot "scripts"

function Show-Menu {
    Clear-Host

    Write-Host "===================================="
    Write-Host "       WINDOWS IT SUPPORT TOOLKIT"
    Write-Host "===================================="
    Write-Host ""
    Write-Host "1. System Information"
    Write-Host "0. Exit"
    Write-Host ""
}

do {
    Show-Menu

    $choice = Read-Host "Enter your choice"

    switch ($choice) {
        "1" {
            . "$scriptPath\system-info.ps1"
            Read-Host "`nPress Enter to return to the menu..."
        }
        "0" {
            Write-Host "Exiting..."
            exit
        }
        default {
            Write-Host "Invalid choice. Please try again."
            Read-Host "`nPress Enter to return to the menu..."
        }
    }
} while ($choice -ne "0")