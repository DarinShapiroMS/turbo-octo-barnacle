 # Powershell script can be run in the cloud shell to add the VM extension Custom Script Extension, configured with
 # the 2 Powershell scripts from this repo that will ensure the local nvme drives always appear as a single
 # striped raid 0 array. 
 # TODO: make this idompotent.  In the meantime, uninstall CSE before running this. 
 
 # update these values 
 $rg = "your resource group"
 $region = "East US"
 $vmName = "vm name"
 
 # leave these values
 $fileURIs = @("https://raw.githubusercontent.com/DarinShapiroMS/turbo-octo-barnacle/main/CustomScriptExtension.ps1", "https://raw.githubusercontent.com/DarinShapiroMS/turbo-octo-barnacle/main/CreateStripedArray.ps1")
 $cmd = "powershell -ExecutionPolicy Unrestricted -File CustomScriptExtension.ps1"
 $settings = @{"fileUris" = $fileURIs; "CommandToExecute" = $cmd};
 Set-AzVMExtension -ResourceGroupName $rg -Location $region -VMName $vmName -Name "CustomScriptExtension" -Publisher "Microsoft.Compute" -Type "CustomScriptExtension" -TypeHandlerVersion "1.10" -Settings $settings
 
