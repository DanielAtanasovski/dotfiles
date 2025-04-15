# Sets up the windows environment

# Set debug level
$DebugPreference = "Continue" # SilentlyContinue, Stop, Inquire, Continue, Ignore

# Set XDG_CONFIG_HOME to %LOCALAPPDATA%
$env:XDG_CONFIG_HOME = $env:LOCALAPPDATA

# Install some packages
winget install --id Microsoft.PowerShell --source winget

# Get this scripts location
$scriptPath = Split-Path -parent $MyInvocation.MyCommand.Definition

# Print the script path
Write-Debug "This Script Path: $scriptPath"

# Setup all the .config folders to be symbolic links to %LOCALAPPDATA%
$configFolderPath = Join-Path -Path $scriptPath -ChildPath "..\.config"
$configFolders = Get-ChildItem -Path $configFolderPath -Directory

# Print the config folders
Write-Debug ".Config Folders: $configFolders"

# Create the symbolic links
foreach ($configFolder in $configFolders) {
    $source = Join-Path -Path $configFolderPath -ChildPath $configFolder
    $destination = Join-Path -Path $env:XDG_CONFIG_HOME -ChildPath $configFolder
    Write-Debug "Creating Symbolic Link: $source -> $destination"
    New-Item -ItemType SymbolicLink -Path $destination -Target $source
}

# Setup powershell profile ($HOME\documents\PowerShell\Profile.ps1)


