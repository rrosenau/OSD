<#
.SYNOPSIS
Takes a Screenshot in WinPE

.DESCRIPTION
Takes a Screenshot in WinPE

.LINK
https://osd.osdeploy.com/module/functions/get-screenshot

.NOTES
21.1.23 Initial Release
#>
function Get-Screenshot {
    [CmdletBinding()]
    Param (
        #Path to save the PE Screenshot
        #Default is $env:TEMP
        [string]$Path = "$Env:TEMP\Screenshots",

        #Saved files will have a Screenshot prefix in the filename
        [string]$Prefix = 'Screenshot',

        #Delay before taking a screenshot in seconds
        #Default: 1
        [uint32]$Delay = 1,

        #Number of Screenshots to capture
        #Default: 1
        [uint32]$Count = 1,

        #Additionally copies the screenshot to the Clipboard
        [switch]$Clipboard = $false,

        #Executes Screenshot
        [switch]$Force = $false
    )
    #======================================================================================================
    #	Force
    #======================================================================================================
    if ($false -eq $Force) {
        $VerbosePreference = 'Continue'
    }
        Write-Verbose 'Get-Screenshot [[-Path] <String>] [[-Prefix] <String>] [[-Delay] <UInt32>] [[-Count] <UInt32>] [-Clipboard] [-Force] [-Verbose]'
        Write-Verbose ''
        Write-Verbose '-Path       Directory where the screenshots will be saved'
        if (!(Test-Path "$Path")) {
            Write-Verbose '            Directory does not exist and will be created'
        }
        Write-Verbose '            Default: $Env:TEMP\Screenshots'
        Write-Verbose "            Value: $Path"
        Write-Verbose ''
        $DateString = (Get-Date).ToString('yyyyMMdd_HHmmss')
        Write-Verbose "-Prefix     Pattern in the file name $($Prefix)_$($DateString).png"
        Write-Verbose '            Default: Screenshot'
        Write-Verbose "            Value: $Prefix"
        Write-Verbose ''
        Write-Verbose '-Count      Number of screenshots to take'
        Write-Verbose '            Default: 1'
        Write-Verbose "            Value: $Count"
        Write-Verbose ''
        Write-Verbose '-Delay      Delay before taking the screenshot in seconds'
        Write-Verbose '            Default: 1'
        Write-Verbose "            Value: $Delay"
        Write-Verbose ''
        Write-Verbose '-Clipboard  Additionally copies the screenshot to the Clipboard'
        Write-Verbose ''
        Write-Verbose '-Force      Required for execution of Get-Screenshot'
        Write-Verbose ''
        Write-Verbose '-Verbose    Displays helpfut startus messages'
        Write-Verbose ''
    #======================================================================================================
    #	Initialize
    #======================================================================================================
    Initialize-Screenshot
    if (! ($Force)) {
        Break
    }
    #======================================================================================================
    #	Create Folder
    #======================================================================================================
    if (!(Test-Path "$Path")) {
        Write-Verbose "Creating directory at $Path"
        New-Item -Path "$Path" -ItemType Directory -Force -ErrorAction Stop | Out-Null
    }
    #======================================================================================================
    #	Delay
    #======================================================================================================
    foreach ($i in 1..$Count) {
        #======================================================================================================
        #	Delay
        #======================================================================================================
        Write-Verbose "Delay $Delay Seconds"
        Start-Sleep -Seconds $Delay
        #======================================================================================================
        #	Start Screenshot Capture
        #======================================================================================================
        Start-Screenshot
        #======================================================================================================
        #	Copy the Screenshot to the Clipboard
        #   https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.clipboard.setimage?view=net-5.0
        #======================================================================================================
        if ($Clipboard) {
            Write-Verbose "Copying screenshot to the Clipboard"
            Add-Type -Assembly System.Drawing
            Add-Type -Assembly System.Windows.Forms
            [System.Windows.Forms.Clipboard]::SetImage($Global:Bitmap)
        }
        #======================================================================================================
        #	Save the Screenshot to File
        #   https://docs.microsoft.com/en-us/dotnet/api/system.drawing.image.tag?view=dotnet-plat-ext-5.0
        #======================================================================================================
        $DateString = (Get-Date).ToString('yyyyMMdd_HHmmss')
        $FileName = "$($Prefix)_$($DateString).png"
        Write-Verbose "Saving screenshot $i of $Count to to $Path\$FileName"
        $Global:Bitmap.Save("$Path\$FileName")
    }
    #======================================================================================================
    #	Close
    #======================================================================================================
    #======================================================================================================
    $Global:Graphics.Dispose()
    $Global:Bitmap.Dispose()
}