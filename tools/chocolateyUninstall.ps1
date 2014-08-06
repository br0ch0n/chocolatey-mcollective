$packageName = 'mcollective' 
try {
	echo "Stopping mcollectived"
	if ((Get-Service mcollectived).Status -eq 'Running') {
		Stop-Service mcollectived
	}
	echo "Removing mcollectived service"
	if (Get-Service "mcollectived" -ErrorAction SilentlyContinue) {
		cd 'C:\Program Files (x86)\Puppet Labs\mcollective\bin'
		.\unregister_service.bat
	}
	echo "Deleting mcollective install dir"
	cd \
	rmdir -Force -Recurse 'C:\Program Files (x86)\Puppet Labs\mcollective'

	Write-ChocolateySuccess 'mcollective'
} 

catch {
Write-ChocolateyFailure 'mcollective' $($_.Exception.Message)
throw
}
