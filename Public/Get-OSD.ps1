<#
.SYNOPSIS
Displays information about the OSD Module

.DESCRIPTION
Displays information about the OSD Module

.LINK
https://osd.osdeploy.com/module/functions/get-osd

.NOTES
#>
function Get-OSD {
    [CmdletBinding()]
    Param ()
    #==================================================
    #   Defaults
    #==================================================
    $Info = $true
    #==================================================
    #   Info
    #==================================================
    if ($Info) {
        $OSDModuleVersion = $($MyInvocation.MyCommand.Module.Version)
        Write-Host "OSD Module PowerShell Shared Library $OSDModuleVersion"
        Write-Host "http://osd.osdeploy.com/release" -ForegroundColor Cyan
        Write-Host
        Write-Host 'Functions'
        Write-Host 'Get-OSD ' -ForegroundColor Cyan -NoNewline
        Write-Host 'This information' -ForegroundColor Gray
        Write-Host 'Get-OSDClass ' -ForegroundColor Cyan -NoNewline
        Write-Host 'Returns CimInstance information from common OSD Classes' -ForegroundColor Gray
        Write-Host 'Get-OSDGather ' -ForegroundColor Cyan -NoNewline
        Write-Host 'Returns common OSD information as an ordered hash table' -ForegroundColor Gray
        Write-Host 'Get-OSDPower ' -ForegroundColor Cyan -NoNewline
        Write-Host 'Displays Power Plan information using powercfg /LIST' -ForegroundColor Gray
        Write-Host 'Get-SessionsXml ' -ForegroundColor Cyan -NoNewline
        Write-Host 'Returns the Session.xml Updates that have been applied to an Operating System' -ForegroundColor Gray
        Write-Host 'Get-OSDWinPE ' -ForegroundColor Cyan -NoNewline
        Write-Host 'Common WinPE Commands using wpeutil and Microsoft DaRT RemoteRecovery' -ForegroundColor Gray
        Write-Host 'Get-RegCurrentVersion ' -ForegroundColor Cyan -NoNewline
        Write-Host 'Returns the Registry Key values from HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -ForegroundColor Gray
        Write-Host 'Save-OSDDownload ' -ForegroundColor Cyan -NoNewline
        Write-Host 'Downloads a file by URL to a destionation folder' -ForegroundColor Gray
        Write-Host
        Write-Host 'Driver Functions'
        Write-Host 'Get-OSDDriver ' -ForegroundColor Cyan -NoNewline
        Write-Host 'Returns Driver download links for Amd Dell Hp Intel and Nvidia' -ForegroundColor Gray
        Write-Host 'Get-OSDDriverWmiQ ' -ForegroundColor Cyan -NoNewline
        Write-Host 'Select multiple Dell or HP Computer Models to generate a proper Task Sequence WMI Query' -ForegroundColor Gray
        Write-Host
        Write-Host 'Disk Functions'
        Write-Host 'New-OSDDisk ' -ForegroundColor Cyan -NoNewline
        Write-Host 'Creates System | OS | Recovery Partitions for MBR or UEFI Drives in WinPE' -ForegroundColor Gray
        Write-Host
        Write-Host 'WindowsImage Functions'
        Write-Host 'Mount-WindowsImageOSD ' -ForegroundColor Cyan -NoNewline
        Write-Host 'Give it a WIM, let it mount it' -ForegroundColor Gray
        Write-Host 'Edit-WindowsImageOSD ' -ForegroundColor Cyan -NoNewline
        Write-Host 'Modify an Online or Offline Windows Image with Cleanup and Appx Stuff' -ForegroundColor Gray
        Write-Host 'Update-WindowsImageOSD ' -ForegroundColor Cyan -NoNewline
        Write-Host 'Identify, Download, and Apply Updates to a Mounted Windows Image' -ForegroundColor Gray
        Write-Host 'Dismount-WindowsImageOSD ' -ForegroundColor Cyan -NoNewline
        Write-Host 'Dismounts WIM by Mounted Path, or all WIMs if no Path is specified' -ForegroundColor Gray
        Write-Host
        Write-Host 'Update the OSD Module'
        Write-Host 'Update-Module OSD -Force' -ForegroundColor Cyan
    }
}