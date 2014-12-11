# Add the git SSH agent to the PATH to avoid "could not find ssh-agent"
$env:path += ";" + (Get-Item "Env:ProgramFiles(x86)").Value + "\Git\bin"

Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

# Load posh-git module
Import-Module posh-git

Enable-GitColors
Pop-Location
Start-SshAgent -Quiet # Start-SshAgent is part of the posh-git module

$GitPromptSettings.EnableFileStatus = $false # speed up git

# git config --global color.status.changed "cyan normal bold"
# git config --global color.status.untracked "cyan normal bold"
# $GitPromptSettings.WorkingForegroundColor    = [ConsoleColor]::Yellow
# $GitPromptSettings.UntrackedForegroundColor  = [ConsoleColor]::Yellow