# Boxstarter Script
# https://boxstarter.org/weblauncher
# START https://boxstarter.org/package/nr/url?https://raw.githubusercontent.com/gambtho/dotfiles/refs/heads/main/win/boxstarter.ps1

function removeApp {
    Param ([string]$appName)
    Write-Host "[DEBUG] Attempting to remove app: $appName"
    try {
        Get-AppxPackage $appName -AllUsers | Remove-AppxPackage -ErrorAction Stop
        Get-AppXProvisionedPackage -Online | Where DisplayName -like $appName | Remove-AppxProvisionedPackage -Online -ErrorAction Stop
        Write-Host "[INFO] Successfully removed app: $appName"
    } catch {
        Write-Host "[WARN] Could not remove app: $appName - $_"
    }
}

# Disable User Account Control
Write-Host "[DEBUG] Disabling UAC..."
Disable-UAC

# Step 1: Configure Windows Features and Settings
Write-Host "[DEBUG] Configuring Windows features and settings..."

# File Explorer Settings
try {
    Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions
    Write-Host "[INFO] Set Windows Explorer options successfully."
    Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1
    Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1
    Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 1
    Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2
    Write-Host "[INFO] Configured File Explorer settings successfully."
} catch {
    Write-Host "[ERROR] Failed to configure File Explorer settings: $_"
}

# Step 2: Remove Default Windows Applications
Write-Host "[DEBUG] Removing unnecessary default applications..."
$applicationList = @(
    "Microsoft.BingFinance", "Microsoft.3DBuilder", "Microsoft.BingNews", "Microsoft.BingSports", 
    "Microsoft.BingWeather", "Microsoft.CommsPhone", "Microsoft.Getstarted", "Microsoft.WindowsMaps",
    "*MarchofEmpires*", "Microsoft.GetHelp", "Microsoft.Messaging", "*Minecraft*", 
    "Microsoft.MicrosoftOfficeHub", "Microsoft.OneConnect", "Microsoft.WindowsPhone", 
    "Microsoft.WindowsSoundRecorder", "*Solitaire*", "Microsoft.MicrosoftStickyNotes", 
    "Microsoft.Office.Sway", "Microsoft.XboxApp", "Microsoft.XboxIdentityProvider", 
    "Microsoft.XboxGameOverlay", "Microsoft.ZuneMusic", "Microsoft.ZuneVideo", 
    "Microsoft.NetworkSpeedTest", "Microsoft.FreshPaint", "Microsoft.Print3D", 
    "Microsoft.People*", "Microsoft.Microsoft3DViewer", "Microsoft.MixedReality.Portal*", 
    "*Skype*", "*Autodesk*", "*BubbleWitch*", "king.com*", "G5*", "*Dell*", "*Facebook*", 
    "*Keeper*", "*Netflix*", "*Twitter*", "*Plex*", "*.Duolingo-LearnLanguagesforFree", 
    "*.EclipseManager", "ActiproSoftwareLLC.562882FEEB491", "*.AdobePhotoshopExpress"
)
foreach ($app in $applicationList) {
    removeApp $app
}

# Step 3: Install Developer Tools
Write-Host "[DEBUG] Installing developer tools..."
try {
    choco install -y vscode git --package-parameters="'/GitAndUnixToolsOnPath /WindowsTerminal'"
    choco install -y python sysinternals powershell-core azure-cli nerd-fonts-hack googlechrome
    Install-Module -Force Az
    Update-SessionEnvironment
    Write-Host "[INFO] Installed developer tools successfully."
} catch {
    Write-Host "[ERROR] Failed to install developer tools: $_"
}

# Step 5: Install Additional Apps
Write-Host "[DEBUG] Installing additional apps..."
$apps = @(
    @{name = "Dropbox.Dropbox"},
    @{name = "Git.Git"},
    @{name = "GnuPG.Gpg4win"},
    @{name = "Google.Chrome"},
    @{name = "JetBrains.Toolbox"},
    @{name = "Microsoft.dotnet"},
    @{name = "Microsoft.PowerShell"},
    @{name = "Microsoft.PowerToys"},
    @{name = "Microsoft.VisualStudioCode"},
    @{name = "Microsoft.WindowsTerminal"},
    @{name = "AgileBits.1Password"},
    @{name = "Doist.Todoist"}
)
foreach ($app in $apps) {
    Write-Host "[DEBUG] Checking if app is installed: $($app.name)"
    $listApp = winget list --exact -q $app.name
    if (![String]::Join("", $listApp).Contains($app.name)) {
        Write-Host "[INFO] Installing: $($app.name)"
        try {
            winget install -e --accept-source-agreements --accept-package-agreements --id $app.name
            Write-Host "[INFO] Successfully installed: $($app.name)"
        } catch {
            Write-Host "[ERROR] Failed to install: $($app.name) - $_"
        }
    } else {
        Write-Host "[INFO] Skipping: $($app.name) (already installed)"
    }
}

# Step 6: Enable Virtualization and WSL
Write-Host "[DEBUG] Enabling virtualization and WSL..."
try {
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    Write-Host "[INFO] Enabled virtualization and WSL successfully."
} catch {
    Write-Host "[ERROR] Failed to enable virtualization and WSL: $_"
}

# Step 4: Re-enable Critical Settings
Write-Host "[DEBUG] Re-enabling critical settings..."
try {
    Enable-UAC
    Enable-MicrosoftUpdate
    Install-WindowsUpdate -acceptEula
    Write-Host "[INFO] Re-enabled critical settings successfully."
} catch {
    Write-Host "[ERROR] Failed to re-enable critical settings: $_"
}

