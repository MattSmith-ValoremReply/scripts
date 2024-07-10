# Install Chrome

$chromeInstallerUrl = "https://dl.google.com/chrome/install/latest/chrome_installer.exe"
$installerPath = "C:\chrome_installer.exe"
Invoke-WebRequest -Uri $chromeInstallerUrl -OutFile $installerPath
Start-Process -FilePath $installerPath -ArgumentList "/silent /install" -Wait
Remove-Item -Path $installerPath

# Run Install Mso Service
$installerPath = "C:\InstallMSOService\InstallMSOService.exe"
Start-Process -FilePath $installerPath -ArgumentList "/silent /install" -Wait
