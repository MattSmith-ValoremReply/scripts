# Install Chrome

$chromeInstallerUrl = "https://dl.google.com/chrome/install/latest/chrome_installer.exe"
$installerPath = "C:\chrome_installer.exe"
Invoke-WebRequest -Uri $chromeInstallerUrl -OutFile $installerPath
Start-Process -FilePath $installerPath -ArgumentList "/silent /install" -Wait
Remove-Item -Path $installerPath

# Run Install Mso Service
$installerPath = "C:\InstallMSOService\InstallMSOService.exe"
Start-Process -FilePath $installerPath -ArgumentList "/silent /install" -Wait

# Install certs
Import-PfxCertificate -CertStoreLocation Cert:\CurrentUser\My -FilePath C:\InstallPreReqCerts\kvcert.pfx
Import-PfxCertificate -CertStoreLocation Cert:\CurrentUser\My -FilePath C:\InstallPreReqCerts\kvreader.pfx
Import-PfxCertificate -CertStoreLocation Cert:\CurrentUser\My -FilePath C:\InstallPreReqCerts\auth.pfx
Import-PfxCertificate -CertStoreLocation Cert:\CurrentUser\My -FilePath C:\InstallPreReqCerts\management.pfx

Import-PfxCertificate -CertStoreLocation Cert:\LocalMachine\My -FilePath C:\InstallPreReqCerts\kvcert.pfx
Import-PfxCertificate -CertStoreLocation Cert:\LocalMachine\My -FilePath C:\InstallPreReqCerts\kvreader.pfx
Import-PfxCertificate -CertStoreLocation Cert:\LocalMachine\My -FilePath C:\InstallPreReqCerts\auth.pfx
Import-PfxCertificate -CertStoreLocation Cert:\LocalMachine\My -FilePath C:\InstallPreReqCerts\management.pfx

# PowerShell PreReqs
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


Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Install-Module SharePointPnPPowerShellOnline -Force
Install-Module -Name AIPService -RequiredVersion 2.0.0.3 -Scope AllUsers -Force -AllowClobber
Install-Module -Name MicrosoftTeams -MinimumVersion 4.0.0 -Scope AllUsers -Force -AllowClobber
Install-Module -Name ExchangeOnlineManagement -RequiredVersion 3.2.0 -Scope AllUsers -Force -AllowClobber
