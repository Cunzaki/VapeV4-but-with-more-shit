# Fallen Cleaner - by Cunzaki
# PowerShell Version

Add-Type -TypeDefinition @"
using System;
using System.Diagnostics;
using System.Runtime.InteropServices;

public class Win32 {
    [DllImport("user32.dll")]
    public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
    
    [DllImport("user32.dll")]
    public static extern bool SetForegroundWindow(IntPtr hWnd);
    
    [DllImport("user32.dll")]
    public static extern IntPtr GetForegroundWindow();
    
    [DllImport("user32.dll")]
    [return: MarshalAs(UnmanagedType.Bool)]
    public static extern bool GetAsyncKeyState(int vKey);
    
    [DllImport("kernel32.dll")]
    public static extern IntPtr GetConsoleWindow();
    
    public const int SW_HIDE = 0;
    public const int SW_SHOW = 5;
    public const int VK_HOME = 0x24;
}
"@

$ErrorActionPreference = "SilentlyContinue"
$robloxPath = Join-Path $env:LOCALAPPDATA "Roblox"
$backupPath = Join-Path $robloxPath "ClientSettings_Backup"
$script:isHidden = $false
$script:filesToDelete = @{}
$script:directoriesToDelete = @()
$consoleWindow = [Win32]::GetConsoleWindow()

# Function to get safe file list (what we keep)
function Get-SafeFiles {
    return @(
        "GlobalBasicSettings_13.xml",
        "GlobalSettings_13.xml"
    )
}

function Get-SafeDirectories {
    return @(
        "ClientSettings",
        "ClientSettings_Backup"
    )
}

# Function to check if Roblox is running
function Test-RobloxRunning {
    $robloxProcesses = @("RobloxPlayerBeta", "RobloxPlayerLauncher", "RobloxStudio", "RobloxStudioBeta")
    foreach ($p in $robloxProcesses) {
        if (Get-Process -Name $p -ErrorAction SilentlyContinue) {
            return $true
        }
    }
    return $false
}

# Function to backup settings
function Backup-Settings {
    Write-Host "Backing up settings..." -ForegroundColor Cyan
    
    if (-not (Test-Path $backupPath)) {
        New-Item -ItemType Directory -Path $backupPath -Force | Out-Null
    }
    
    # Backup global settings
    $safeFiles = Get-SafeFiles
    foreach ($file in $safeFiles) {
        $source = Join-Path $robloxPath $file
        if (Test-Path $source) {
            Copy-Item -Path $source -Destination $backupPath -Force
            Write-Host "  Backed up: $file" -ForegroundColor Green
        }
    }
    
    # Backup ClientSettings
    $clientSettings = Join-Path $robloxPath "ClientSettings"
    $clientSettingsBackup = Join-Path $backupPath "ClientSettings"
    if (Test-Path $clientSettings) {
        if (Test-Path $clientSettingsBackup) {
            Remove-Item -Path $clientSettingsBackup -Recurse -Force
        }
        Copy-Item -Path $clientSettings -Destination $backupPath -Recurse -Force
        Write-Host "  Backed up: ClientSettings" -ForegroundColor Green
    }
}

# Function to restore settings
function Restore-Settings {
    Write-Host "Restoring settings..." -ForegroundColor Cyan
    
    # Restore global settings
    $safeFiles = Get-SafeFiles
    foreach ($file in $safeFiles) {
        $source = Join-Path $backupPath $file
        $dest = Join-Path $robloxPath $file
        if (Test-Path $source) {
            Copy-Item -Path $source -Destination $dest -Force
            Write-Host "  Restored: $file" -ForegroundColor Green
        }
    }
    
    # Restore ClientSettings
    $clientSettingsBackup = Join-Path $backupPath "ClientSettings"
    $clientSettings = Join-Path $robloxPath "ClientSettings"
    if (Test-Path $clientSettingsBackup) {
        if (Test-Path $clientSettings) {
            Remove-Item -Path $clientSettings -Recurse -Force
        }
        Copy-Item -Path $clientSettingsBackup -Destination $robloxPath -Recurse -Force
        Write-Host "  Restored: ClientSettings" -ForegroundColor Green
    }
}

# Function to clean folder (one-time)
function Clean-Folder {
    Write-Host "Cleaning Roblox folder..." -ForegroundColor Cyan
    Backup-Settings
    
    $safeFiles = Get-SafeFiles
    $safeDirs = Get-SafeDirectories
    
    # Delete directories
    Get-ChildItem -Path $robloxPath -Directory -ErrorAction SilentlyContinue | ForEach-Object {
        if ($safeDirs -notcontains $_.Name) {
            try {
                Remove-Item -Path $_.FullName -Recurse -Force -ErrorAction Stop
                Write-Host "  Removed: $($_.Name)" -ForegroundColor Yellow
            }
            catch {
                # Ignore errors
            }
        }
    }
    
    # Delete files
    Get-ChildItem -Path $robloxPath -File -ErrorAction SilentlyContinue | ForEach-Object {
        if ($safeFiles -notcontains $_.Name) {
            try {
                Remove-Item -Path $_.FullName -Force -ErrorAction Stop
                Write-Host "  Removed file: $($_.Name)" -ForegroundColor Yellow
            }
            catch {
                # Ignore errors
            }
        }
    }
    
    Restore-Settings
    Write-Host "`nCleaning complete!" -ForegroundColor Green
}

# Function to try to delete a file
function Try-DeleteFile($path) {
    try {
        Remove-Item -Path $path -Force -ErrorAction Stop
        return $true
    }
    catch {
        return $false
    }
}

# Function to try to delete a directory
function Try-DeleteDirectory($path) {
    try {
        Remove-Item -Path $path -Recurse -Force -ErrorAction Stop
        return $true
    }
    catch {
        return $false
    }
}

# Function to toggle window visibility
function Toggle-Window {
    $script:isHidden = -not $script:isHidden
    if ($script:isHidden) {
        [Win32]::ShowWindow($consoleWindow, [Win32]::SW_HIDE)
    }
    else {
        [Win32]::ShowWindow($consoleWindow, [Win32]::SW_SHOW)
        [Win32]::SetForegroundWindow($consoleWindow)
    }
}

# Main menu
function Show-Menu {
    Clear-Host
    Write-Host "Fallen Cleaner - by Cunzaki" -ForegroundColor Magenta
    Write-Host ""
    Write-Host "[1] Clean Roblox Folder" -ForegroundColor White
    Write-Host "[2] Monitor Roblox Folder (Clean on Exit)" -ForegroundColor White
    Write-Host "[3] Exit" -ForegroundColor White
    Write-Host ""
    Write-Host "Note: In monitor mode, press HOME to hide/show window" -ForegroundColor Cyan
    Write-Host ""
}

# Monitor function - waits for Roblox to close then cleans
function Start-Monitor {
    Clear-Host
    Write-Host "Fallen Cleaner - by Cunzaki" -ForegroundColor Magenta
    Write-Host "Monitoring Roblox folder - will clean when Roblox closes..." -ForegroundColor Cyan
    Write-Host "(Press HOME to hide/show, Ctrl+C to stop)" -ForegroundColor Gray
    Write-Host ""
    
    $safeFiles = Get-SafeFiles
    $safeDirs = Get-SafeDirectories
    $script:filesToDelete = @{}
    $script:directoriesToDelete = @()
    $robloxWasRunning = $false
    
    # Variable for key debounce
    $lastHomePress = [DateTime]::MinValue
    
    # Setup FileSystemWatcher to track new files
    $watcher = New-Object System.IO.FileSystemWatcher
    $watcher.Path = $robloxPath
    $watcher.IncludeSubdirectories = $false
    $watcher.NotifyFilter = [System.IO.NotifyFilters]::FileName -bor [System.IO.NotifyFilters]::DirectoryName
    $watcher.EnableRaisingEvents = $true
    
    # Register events
    $createdEvent = Register-ObjectEvent -InputObject $watcher -EventName Created -Action {
        $path = $Event.SourceEventArgs.FullPath
        $name = $Event.SourceEventArgs.Name
        $safeFiles = Get-SafeFiles
        $safeDirs = Get-SafeDirectories
        
        if (Test-Path $path -PathType Container) {
            if ($safeDirs -notcontains $name) {
                $script:directoriesToDelete += $path
            }
        }
        else {
            if ($safeFiles -notcontains $name) {
                $script:filesToDelete[$path] = Get-Date
            }
        }
    }
    
    # Main loop
    try {
        while ($true) {
            # Check for HOME key
            if ([Win32]::GetAsyncKeyState([Win32]::VK_HOME)) {
                $now = [DateTime]::Now
                if (($now - $lastHomePress).TotalMilliseconds -gt 500) {
                    Toggle-Window
                    $lastHomePress = $now
                }
            }
            
            # Check Roblox status
            $robloxIsRunning = Test-RobloxRunning
            
            if ($robloxIsRunning) {
                $robloxWasRunning = $true
                if (-not $script:isHidden) {
                    Write-Host "Roblox is running - tracking new files/folders..." -ForegroundColor Cyan -NoNewline
                    Write-Host "`r" -NoNewline
                }
            }
            else {
                if ($robloxWasRunning) {
                    Write-Host ""
                    Write-Host "Roblox closed - cleaning up..." -ForegroundColor Magenta
                    
                    # Clean up all tracked files/directories
                    $deletedCount = 0
                    
                    foreach ($dir in $script:directoriesToDelete) {
                        if (Test-Path $dir) {
                            if (Try-DeleteDirectory $dir) {
                                if (-not $script:isHidden) {
                                    Write-Host "  Removed: $(Split-Path $dir -Leaf)" -ForegroundColor Yellow
                                }
                                $deletedCount++
                            }
                        }
                    }
                    
                    foreach ($file in $script:filesToDelete.Keys) {
                        if (Test-Path $file) {
                            if (Try-DeleteFile $file) {
                                if (-not $script:isHidden) {
                                    Write-Host "  Removed file: $(Split-Path $file -Leaf)" -ForegroundColor Yellow
                                }
                                $deletedCount++
                            }
                        }
                    }
                    
                    # Reset tracking
                    $script:filesToDelete = @{}
                    $script:directoriesToDelete = @()
                    $robloxWasRunning = $false
                    
                    Write-Host "Cleanup complete! Removed $deletedCount item(s)." -ForegroundColor Green
                }
                else {
                    if (-not $script:isHidden) {
                        Write-Host "Waiting for Roblox to start...                    " -ForegroundColor Gray -NoNewline
                        Write-Host "`r" -NoNewline
                    }
                }
            }
            
            # Small sleep to reduce CPU usage
            Start-Sleep -Milliseconds 50
        }
    }
    finally {
        # Cleanup
        try { Unregister-Event -SourceIdentifier $createdEvent.Name -ErrorAction SilentlyContinue } catch {}
        try { $watcher.Dispose() } catch {}
    }
}

# Main script execution
while ($true) {
    Show-Menu
    $choice = Read-Host "Choose an option"
    
    switch ($choice) {
        "1" {
            Clean-Folder
            Write-Host "`nPress any key to return to menu..."
            $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        }
        "2" {
            Start-Monitor
        }
        "3" {
            exit
        }
    }
}
