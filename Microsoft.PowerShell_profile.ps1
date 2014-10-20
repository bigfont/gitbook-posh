﻿
#
# Console customizations
# Note that we cannot easily control the font-family nor font-size
# in script. Rather, we set those through properties. The 'Properties'
# apply per shortcut and override the 'Defaults'. My favorites are:
#   Size: 20
#   Font: Lucida Console
#   Cursor Size: Medium
# See windowsitpro.com/powershell/powershell-basics-console-configuration
# -------------------------

# Customize the prompt
function prompt
{
   Write-Host ("Shaun>") -nonewline -foregroundcolor Yellow
   return " "
}

# customize colors
$ui = $HOST.UI.RawUI;
$ui.ForegroundColor = 'Yellow';

$size = $ui.WindowSize
$size.Width = 105;
$size.Height = 35;
$ui.WindowSize = $size;

# the buffer size must exceed the window size
$buffer = $ui.BufferSize;
$buffer.Width = 105;
$buffer.Height = 2000;
$ui.BufferSize = $buffer;

$ui.WindowPosition.x = 0;
$ui.WindowPosition.y = 0;

#
# Emulate 'run' behavior with most programs
# -------------------------

$regkey = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths'

$appPaths = Get-ChildItem $regkey |
  Get-ItemProperty |
  ? { $_.'(default)' } |
  select -Expand '(default)' |
  Split-Path -Parent |
  % { [Environment]::ExpandEnvironmentVariables($_.TrimStart('"')) } |
  select -Unique

$env:PATH += ';' + ($appPaths -join ';')

#
# Posh Git
# -------------------------

# Add the git SSH agent to the PATH to avoid "could not find ssh-agent"
$env:path += ";" + (Get-Item "Env:ProgramFiles(x86)").Value + "\Git\bin"

# Load posh-git example profile
# . 'C:\tools\poshgit\dahlbyk-posh-git-95df787\profile.example.ps1'

# Load my posh-git profile using the dot-source notation
. 'C:\Users\BigFont\Documents\WindowsPowerShell\My.PoshGitProfile.ps1'

<<<<<<< HEAD
# Load Posh-GitHub
. 'C:\Users\BigFont\Documents\WindowsPowerShell\Modules\Posh-GitHub\Posh-GitHub-Profile.ps1'
=======
# Customize the prompt
function prompt
{
   Write-Host ("Shaun>") -nonewline -foregroundcolor White
   return " "
}

# Helper functions

function firefox 
{
  Start-Process firefox.exe
}
>>>>>>> e46f1813ff757eddc2fa9a4fd59b7fc4a1c0304e
