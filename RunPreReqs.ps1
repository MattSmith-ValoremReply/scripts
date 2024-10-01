# Install Chrome
$chromeInstallerUrl = "https://dl.google.com/chrome/install/latest/chrome_installer.exe"
$installerPath = "C:\chrome_installer.exe"
Invoke-WebRequest -Uri $chromeInstallerUrl -OutFile $installerPath
Start-Process -FilePath $installerPath -ArgumentList "/silent /install" -Wait
Remove-Item -Path $installerPath

# Run Install Mso Service
$installerPath = "C:\InstallMSOService\InstallMSOService.exe"
Start-Process -FilePath $installerPath -ArgumentList "/silent /install" -Wait

# Install the PowerApps CLI
Start-Process msiexec.exe -ArgumentList '/qn', '/i', 'C:\PowerAppsCLI\powerapps-cli-1.0.msi', 'ALLUSERS=1', '/norestart', '/L*V', 'install.log' -NoNewWindow -Wait

# Install certs
Import-PfxCertificate -CertStoreLocation Cert:\CurrentUser\My -FilePath C:\InstallPreReqCerts\kvcert.pfx
Import-PfxCertificate -CertStoreLocation Cert:\CurrentUser\My -FilePath C:\InstallPreReqCerts\kvcert2.pfx
Import-PfxCertificate -CertStoreLocation Cert:\CurrentUser\My -FilePath C:\InstallPreReqCerts\kvreader.pfx
Import-PfxCertificate -CertStoreLocation Cert:\CurrentUser\My -FilePath C:\InstallPreReqCerts\auth.pfx
Import-PfxCertificate -CertStoreLocation Cert:\CurrentUser\My -FilePath C:\InstallPreReqCerts\management.pfx

Import-PfxCertificate -CertStoreLocation Cert:\LocalMachine\My -FilePath C:\InstallPreReqCerts\kvcert.pfx
Import-PfxCertificate -CertStoreLocation Cert:\CurrentUser\My -FilePath C:\InstallPreReqCerts\kvcert2.pfx
Import-PfxCertificate -CertStoreLocation Cert:\LocalMachine\My -FilePath C:\InstallPreReqCerts\kvreader.pfx
Import-PfxCertificate -CertStoreLocation Cert:\LocalMachine\My -FilePath C:\InstallPreReqCerts\auth.pfx
Import-PfxCertificate -CertStoreLocation Cert:\LocalMachine\My -FilePath C:\InstallPreReqCerts\management.pfx

# Cleanup Potential PowerShell Conflicts
try
{
	Uninstall-Module -Name AIPService -Force
}
catch
{
	# Ignore. Move on.
}

try
{
	Uninstall-Module -Name ExchangeOnlineManagement -Force
}
catch
{
	# Ignore. Move on.
}

# Install PowerShell Pre-Reqs
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Install-Module SharePointPnPPowerShellOnline -Force
Install-Module -Name AIPService -RequiredVersion 2.0.0.3 -Scope AllUsers -Force -AllowClobber
Install-Module -Name MicrosoftTeams -RequiredVersion 4.0.0 -Scope AllUsers -Force -AllowClobber
Install-Module -Name ExchangeOnlineManagement -RequiredVersion 3.2.0 -Scope AllUsers -Force -AllowClobber

# Run Hydration Engine
Start-Process "C:\HydrationEngine\ProvisioningWorkerBootstrap.exe"

Restart-Computer -Force
