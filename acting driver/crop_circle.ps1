Add-Type -AssemblyName System.Drawing

$srcPath = "d:\persnal\antigravity agent ai\acting driver\sk_logo_cropped.png"
$dstPath = "d:\persnal\antigravity agent ai\acting driver\sk_circle_emblem.png"

$src = [System.Drawing.Bitmap]::FromFile($srcPath)

# The circle emblem is in the top 70% of the cropped image
$cropW = 320
$cropH = 320
$cropX = [int](($src.Width - $cropW) / 2)
$cropY = 5

$rect = New-Object System.Drawing.Rectangle($cropX, $cropY, $cropW, $cropH)
$cropped = $src.Clone($rect, $src.PixelFormat)
$cropped.Save($dstPath, [System.Drawing.Imaging.ImageFormat]::Png)

$src.Dispose()
$cropped.Dispose()

Write-Output "Saved circular emblem to $dstPath"
