<#
.SYNOPSIS
Selects Office Configuration Profiles

.DESCRIPTION
Selects Office Configuration Profiles

.LINK
https://osdcloud.osdeploy.com

.NOTES
#>
function Select-OSDCloudOffline.wim {
    [CmdletBinding()]
    param ()

    $i = $null
    $Results = Find-OSDCloudOffline.wim

    if ($Results) {
        $Results = foreach ($Item in $Results) {
            $i++

            $ObjectProperties = @{
                Selection   = $i
                Name        = $Item.Name
                Directory   = $Item.Directory
            }
            New-Object -TypeName PSObject -Property $ObjectProperties
        }

        $Results | Select-Object -Property Selection, Name, Directory | Format-Table | Out-Host

        do {
            $SelectReadHost = Read-Host -Prompt "Enter the Selection of the Operating System WIM to apply"
        }
        until (((($SelectReadHost -ge 0) -and ($SelectReadHost -in $Results.Selection))))
        
        if ($SelectReadHost -eq 'S') {
            Return $false
        }
        $Results = $Results | Where-Object {$_.Selection -eq $SelectReadHost}

        Return Get-Item (Join-Path $Results.Directory $Results.Name)
    }
}