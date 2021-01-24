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
        #Delay before taking a screenshot in seconds
        #Defautl is 0
        [uint32]$Delay = 0,

        #Name of the Screenshot File
        #Default is yyyyMMdd_HHmmss.png
        [string]$Name = "Screenshot-$((Get-Date).ToString('yyyyMMdd_HHmmss')).png",

        #Path to save the PE Screenshot
        #Default is $env:TEMP
        [string]$Path = $Env:TEMP,

        #Number of Screenshots to capture
        #Default is 1
        [uint32]$Count = 1,

        #Executes Screenshot
        [switch]$Force = $false
    )
    #======================================================================================================
    #	Force
    #======================================================================================================
    Write-Verbose -Verbose "Get-Screenshot will capture a Screenshot"
    Write-Verbose -Verbose "Path: $Path"
    Write-Verbose -Verbose "Name: $Name"
    Write-Verbose -Verbose "Count: $Count"
    Write-Verbose -Verbose "Delay: $Delay Seconds"
    Write-Verbose -Verbose "Force: Use the Force Parameter to execute the command"
    #======================================================================================================
    #	Create Folder
    #======================================================================================================
    if (!(Test-Path "$Path")) {
        if ($force) {
            Write-Verbose "Creating directory $Path"
            New-Item -Path "$Path" -ItemType Directory -Force -ErrorAction Stop | Out-Null
        } else {
            Write-Verbose "Creating directory $Path"
        }
    }
    #======================================================================================================
    #	Delay
    #======================================================================================================
    foreach ($i in 1..$Count) {
        #======================================================================================================
        #	Delay
        #======================================================================================================
        Write-Verbose "Waiting $Delay Seconds"
        Start-Sleep -Seconds $Delay
        #======================================================================================================
        #	Set VirtualScreen and GraphicObject
        #======================================================================================================
        $Global:VirtualScreen = Get-VirtualScreen
        $Global:ScreenBitmap = Get-ScreenBitmap
        $Global:GraphicObject = Get-GraphicObject
        Set-GraphicObject
        #======================================================================================================
        #	Capture Screenshot
        #======================================================================================================
        $DateString = (Get-Date).ToString('yyyyMMdd_HHmmss')
        $FileName = "Screenshot-$($DateString).png"
        Write-Verbose "Capturing Screenshot $i of $Count to $Path\$FileName"
        $Global:ScreenBitmap.Save("$Path\$FileName")
    }
}