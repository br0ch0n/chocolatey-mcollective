$packageName = 'mcollective' 
$url = 'https://github.com/puppetlabs/marionette-collective/archive/2.5.3.zip'
$unzipLocation = 'C:\Program Files (x86)\Puppet Labs'

try {
	New-Item -ItemType Directory -Force -Path $unzipLocation
	Install-ChocolateyZipPackage $packageName $url $unzipLocation
	echo "This install is assuming that you're managing your server.cfg, client.cfg and facts.yaml via puppet.  Don't expect it to work right otherwise."
	echo "See https://github.com/puppetlabs/marionette-collective/blob/2.5.3/ext/windows/README.md for details"
	ren 'C:\Program Files (x86)\Puppet Labs\marionette-collective-2.5.3' 'C:\Program Files (x86)\Puppet Labs\mcollective'
	copy 'C:\Program Files (x86)\Puppet Labs\mcollective\ext\windows\*' 'C:\Program Files (x86)\Puppet Labs\mcollective\bin\'
	cd 'C:\Program Files (x86)\Puppet Labs\mcollective\bin\'
	.\register_service.bat
	Write-ChocolateySuccess 'mcollective'
} 
catch {
Write-ChocolateyFailure 'mcollective' $($_.Exception.Message)
throw
}
