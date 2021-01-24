function Get-ScreenshotDpiScaling {
    [CmdletBinding()]
    Param ()
    # Get DPI Scaling
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")

    Add-Type @'
  using System; 
  using System.Runtime.InteropServices;
  using System.Drawing;

  public class DPI {  
    [DllImport("gdi32.dll")]
    static extern int GetDeviceCaps(IntPtr hdc, int nIndex);

    public enum DeviceCap {
      VERTRES = 10,
      DESKTOPVERTRES = 117
    } 

    public static float scaling() {
      Graphics g = Graphics.FromHwnd(IntPtr.Zero);
      IntPtr desktop = g.GetHdc();
      int LogicalScreenHeight = GetDeviceCaps(desktop, (int)DeviceCap.VERTRES);
      int PhysicalScreenHeight = GetDeviceCaps(desktop, (int)DeviceCap.DESKTOPVERTRES);

      return (float)PhysicalScreenHeight / (float)LogicalScreenHeight;
    }
  }
'@ -ReferencedAssemblies 'System.Drawing.dll'
    Return [DPI]::scaling() * 100
}
function Initialize-Screenshot {
    [CmdletBinding()]
    Param ()
    # Get Dpi Scaling
    $Global:ScreenshotDpiScaling = Get-ScreenshotDpiScaling
    Write-Verbose "Screen DPI Scaling is $([Math]::round($Global:ScreenshotDpiScaling, 0)) Percent"

    # Get Virtual Screen Resolution
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
    $Global:VirtualScreen = [System.Windows.Forms.SystemInformation]::VirtualScreen
    Write-Verbose "Virtual Screen resolution is $($Global:VirtualScreen.Width) x $($Global:VirtualScreen.Height)"

    # Get Physical Screen Resolution
    $scale = [math]::round([dpi]::scaling(), 2) * 100
    [int32]$Global:VirtualScreenWidth = [math]::round($(($Global:VirtualScreen.Width * $Global:ScreenshotDpiScaling) / 100), 0)
    [int32]$Global:VirtualScreenHeight = [math]::round($(($Global:VirtualScreen.Height * $Global:ScreenshotDpiScaling) / 100), 0)
    Write-Verbose "Physical Screen resolution is $($Global:VirtualScreenWidth) x $($Global:VirtualScreenHeight)"
}
function Start-Screenshot {
    [CmdletBinding()]
    Param ()
    # Create Bitmap Object
    $Global:Bitmap = New-Object System.Drawing.Bitmap $Global:VirtualScreenWidth, $Global:VirtualScreenHeight

    # Create a Graphics Object to Draw the Bitmap
    $Global:Graphics = [System.Drawing.Graphics]::FromImage($Global:Bitmap)

    # Take a Screenshot
    $Global:Graphics.CopyFromScreen($Global:VirtualScreen.Left, $Global:VirtualScreen.Top, 0, 0, $Global:Bitmap.Size)
}