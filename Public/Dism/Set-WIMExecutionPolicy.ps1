<#
.SYNOPSIS
Sets the PowerShell Execution Policy of a .wim File

.DESCRIPTION
Sets the PowerShell Execution Policy of a .wim File

.LINK
https://osd.osdeploy.com/module/functions/dism/set-wimexecutionpolicy

.NOTES
21.2.1  Initial Release
#>
function Set-WimExecutionPolicy {
    [CmdletBinding()]
    param (
        #Specifies the location of the WIM or VHD file containing the Windows image you want to mount.
        [Parameter(
            Mandatory = $true,
            ValueFromPipelineByPropertyName
        )]
        [string[]]$ImagePath,

        #Index of the WIM to Mount
        #Default is 1
        [Parameter(
            ValueFromPipelineByPropertyName
        )]
        [UInt32]$Index = 1,

        #PowerShell Execution Policy setting
        [Parameter(
            Mandatory=$true,
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateSet('AllSigned', 'Bypass', 'Default', 'RemoteSigned', 'Restricted', 'Undefined', 'Unrestricted')]
        [string]$ExecutionPolicy
    )

    begin {
        #===================================================================================================
        #   Require Admin Rights
        #===================================================================================================
        if ((Get-OSDGather -Property IsAdmin) -eq $false) {
            Write-Warning 'Set-WimExecutionPolicy requires Admin Rights ELEVATED'
            Break
        }
        #===================================================================================================
    }
    process {
        foreach ($Input in $ImagePath) {
            #===============================================================================================
            $MountWindowsImageOSD = Mount-MyWindowsImage -ImagePath $Input -Index $Index
            $MountWindowsImageOSD | Set-WindowsImageExecutionPolicy -ExecutionPolicy $ExecutionPolicy
            $MountWindowsImageOSD | Dismount-MyWindowsImage -Save
            #===============================================================================================
        }
    }
    end {}
}