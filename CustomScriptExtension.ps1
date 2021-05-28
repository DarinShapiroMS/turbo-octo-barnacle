# this PowerShell script is downloaded to VM by Custom Script Extension.  It's
# purpose is to create a Windows Scheduled Task to run a 2nd PowerShell script 
# Downloaded but the Custom Script Extension


$pathOfCurrentScript = Split-Path $MyInvocation.MyCommand.Path -Parent
$pathOfCreateScript = "$pathOfCurrentScript\CreateStripedLocalDisks.ps1"

# create Windows Scheduled Task to run that script at VM startup

$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument "-File $pathOfCreateScript -NoProfile -WindowStyle Hidden"
$trigger =  New-ScheduledTaskTrigger -AtStartup
Register-ScheduledTask -Action $action -Trigger $trigger -User "System" -RunLevel Highest -TaskName "fast-temp-disk-create" -Description "creation of striped array of local nvme disks"
