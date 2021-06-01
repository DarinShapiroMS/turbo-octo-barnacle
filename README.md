# turbo-octo-barnacle
A set of PowerShell scripts to bootstrap temp local nvme drives on Azure HB120rs_V3 Virtual Machines

## Instructions
1. Run [InstallExtension.ps1](InstallExtension.ps1) using the Azure CLI or Azure Cloudshell.  This adds the Custom Script Extension for Windows to a Virtual Machine, configured to deliver 2 other files to the Virtual Machine.  
2. This will cause [CustomeScriptExtension.ps1](CustomScriptExtension.ps1) to be downloaded and executed on the VM, which creates a Windows Scheduled Task to run [CreateStripedArray.ps1](CreateStripedArray.ps1) upon even startup of the VM. The scheduled task creates a Windows Storage Space and a striped array using the local NVME disks. 
3. Configure any necessary apps to use the E: disk.

#### ** Remember that these disks are temporary and the data will be lost upon deallocation or any maintaince event causing the VM to be placed on a different host. 
