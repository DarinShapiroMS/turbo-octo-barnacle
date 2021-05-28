# Simple Powershell script to configure local nvme drives into raid 0 array.
# !this has to be idempotent!

$storagepoolname = localNvmePool
$virtualdiskname = localNvmeVirtualDisk
$fileSystemLabel = LocalFastTemp

# assume if an e: drive exists, no need to create again. 
If(!( Test-Path -Path 'e:\'))
{
# get list of uninitialized disks (on HBv3 there are 2 local nvme drives)
$PhysicalDisks = (Get-PhysicalDisk -CanPool $True)

# create new Windows Storage Spaces pool with those disks
New-StoragePool -FriendlyName $storagepoolname -StorageSubSystemFriendlyName 'Windows Storage*' -PhysicalDisks $PhysicalDisks

# create a new virtual disk
New-VirtualDisk -StoragePoolFriendlyName $storagepoolname -FriendlyName $virtualdiskname -ResiliencySettingName Simple -UseMaximumSize

# parition, format, and initialize the striped disks
Get-VirtualDisk -FriendlyName StoragePoolDisk | Get-Disk | Initialize-Disk -PassThru | New-Partition -AssignDriveLetter -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel $fileSystemLabel
}
