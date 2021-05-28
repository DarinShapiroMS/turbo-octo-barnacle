# this PowerShell script is downloaded to VM by Custom Script Extension.  It's
# purpose is to download another Powershell script that is run at startup by a 
# Windows Scheduled Task.


$scriptURL  = 'https://raw.githubusercontent.com/DarinShapiroMS/turbo-octo-barnacle/main/CreateStripedArray.ps1'
$downloadPath = 'c:\CreateStripedArray.ps1'

# download script to local path
(New-Object Net.WebClient).DownloadFile($scriptURL,$downloadPath);

# create Windows Scheduled Task to run that script at VM startup

$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument "-File $downloadPath -NoProfile -WindowStyle Hidden"
$trigger =  New-ScheduledTaskTrigger -AtStartup
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "fast-temp-disk-create" -Description "creation of striped array of local nvme disks"
