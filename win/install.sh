# 1. Make sure the Microsoft App Installer is installed:
#    https://www.microsoft.com/en-us/p/app-installer/9nblggh4nns1
# 2. Edit the list of apps to install.
# 3. Run this script as administrator.
# 4. update with path to this file - iex ((New-Object System.Net.WebClient).DownloadString('https://gist.githubusercontent.com/AdamDimech/08ba988211b55c71a480449b3b8ab6cd/raw'))

Write-Output "Installing Apps"
$apps = @(
    @{name = "Dropbox.Dropbox" },
    @{name = "Git.Git" },
    @{name = "GnuPG.Gpg4win" },
    @{name = "Google.Chrome" },
    @{name = "JetBrains.Toolbox" },
    @{name = "Microsoft.dotnet" },
    @{name = "Microsoft.PowerShell" },
    @{name = "Microsoft.PowerToys" },
    @{name = "Microsoft.VisualStudioCode" },
    @{name = "Microsoft.WindowsTerminal" },
    @{name = "AgileBits.1Password"},
    @{name = "Doist.Todoist"},
);
Foreach ($app in $apps) {
    $listApp = winget list --exact -q $app.name
    if (![String]::Join("", $listApp).Contains($app.name)) {
        Write-host "Installing: " $app.name
        winget install -e -h --accept-source-agreements --accept-package-agreements --id $app.name 
    }
    else {
        Write-host "Skipping: " $app.name " (already installed)"
    }
}

# STEP 1: Enable Virtual Machine Platform feature
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# STEP 2: Enable WSL feature
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
