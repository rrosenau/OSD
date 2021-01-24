

function Get-FullRes {
    [CmdletBinding()]
    Param ()

    # Get Screen Dimensions
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 
    $Global:VirtualScreen = [System.Windows.Forms.SystemInformation]::VirtualScreen
    Return $Global:VirtualScreen | Select-Object -Property *
}