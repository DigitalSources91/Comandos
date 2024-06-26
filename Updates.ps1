Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

choco install pswindowsupdate --version=2.2.0.2

Get-Package -Name PSWindowsUpdate

Get-command -module PSWindowsUpdate

Get-WUApiVersion

Get-WindowsUpdate

Install-WindowsUpdate -MicrosoftUpdate -AcceptAll
