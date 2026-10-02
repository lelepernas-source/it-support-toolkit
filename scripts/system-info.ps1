Clear-Host

Write-Host "===================================="
Write-Host "        SYSTEM INFORMATION"
Write-Host "===================================="
Write-Host ""

# Computer
$computer = Get-CimInstance Win32_ComputerSystem
$os = Get-CimInstance Win32_OperatingSystem
$cpu = Get-CimInstance Win32_Processor | Select-Object -First 1

Write-Host "Computer Name : $env:COMPUTERNAME"
Write-Host "Manufacturer  : $($computer.Manufacturer)"
Write-Host "Model         : $($computer.Model)"
Write-Host ""

# Windows
Write-Host "=== WINDOWS ==="
Write-Host "Edition       : $($os.Caption)"
Write-Host "Version       : $($os.Version)"
Write-Host "Architecture  : $($os.OSArchitecture)"
Write-Host ""

# CPU / RAM
Write-Host "=== HARDWARE ==="
Write-Host "CPU           : $($cpu.Name)"

$ramGB = [math]::Round($computer.TotalPhysicalMemory / 1GB, 2)
Write-Host "RAM           : $ramGB GB"
Write-Host ""

# User
Write-Host "=== USER ==="
Write-Host "Username      : $env:USERNAME"
Write-Host "Domain        : $env:USERDOMAIN"
Write-Host ""

# IP
Write-Host "=== NETWORK ==="

$adapters = Get-CimInstance Win32_NetworkAdapterConfiguration |
    Where-Object { $_.IPEnabled -eq $true }

foreach ($adapter in $adapters) {

    Write-Host "Interface : $($adapter.Description)"

    foreach ($ip in $adapter.IPAddress) {
        if ($ip -match '^\d{1,3}(\.\d{1,3}){3}$') {
            Write-Host "IPv4      : $ip"
        }
    }

    Write-Host ""
}

# Disk
Write-Host "=== DISKS ==="

$disks = Get-CimInstance Win32_LogicalDisk |
    Where-Object { $_.DriveType -eq 3 }

foreach ($disk in $disks) {

    $sizeGB = [math]::Round($disk.Size / 1GB, 2)
    $freeGB = [math]::Round($disk.FreeSpace / 1GB, 2)
    $usedPercent = [math]::Round((1 - ($disk.FreeSpace / $disk.Size)) * 100, 1)

    Write-Host ""
    Write-Host "Drive        : $($disk.DeviceID)"
    Write-Host "Total        : $sizeGB GB"
    Write-Host "Free         : $freeGB GB"
    Write-Host "Used         : $usedPercent%"

    if ($usedPercent -ge 90) {
        Write-Host "[WARNING] Disk space is critically low!"
    }
    elseif ($usedPercent -ge 80) {
        Write-Host "[WARNING] Disk space is getting low."
    }
    else {
        Write-Host "[OK] Disk space"
    }
}

Write-Host ""
Write-Host "===================================="
Write-Host "             COMPLETE"
Write-Host "===================================="