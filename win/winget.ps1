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
    @{name = "Doist.Todoist"}
);
Foreach ($app in $apps) {
    $listApp = winget list --exact -q $app.name
    if (![String]::Join("", $listApp).Contains($app.name)) {
        Write-host "Installing: " $app.name
        winget install -e --accept-source-agreements --accept-package-agreements --id $app.name 
    }
    else {
        Write-host "Skipping: " $app.name " (already installed)"
    }
}

# STEP 1: Enable Virtual Machine Platform feature
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# STEP 2: Enable WSL feature
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
