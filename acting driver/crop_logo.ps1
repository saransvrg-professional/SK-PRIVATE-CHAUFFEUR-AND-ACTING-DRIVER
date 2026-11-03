Add-Type -AssemblyName System.Drawing

$srcPath = "d:\persnal\antigravity agent ai\acting driver\sk_brand_logo_full.jpg"
$dstPath = "d:\persnal\antigravity agent ai\acting driver\sk_logo_cropped.png"

$src = [System.Drawing.Bitmap]::FromFile($srcPath)
Write-Output "Original Size: $($src.Width) x $($src.Height)"

# Find the bounding box of non-black pixels (brightness > 20)
$minX = $src.Width
$maxX = 0
$minY = $src.Height
$maxY = 0

for ($y = 0; $y -lt $src.Height; $y += 4) {
    for ($x = 0; $x -lt $src.Width; $x += 4) {
        $pixel = $src.GetPixel($x, $y)
        $brightness = [Math]::Max($pixel.R, [Math]::Max($pixel.G, $pixel.B))
        if ($brightness -gt 35) {
            if ($x -lt $minX) { $minX = $x }
            if ($x -gt $maxX) { $maxX = $x }
            if ($y -lt $minY) { $minY = $y }
            if ($y -gt $maxY) { $maxY = $y }
        }
    }
}

# Add 20px padding
$pad = 20
$cropX = [Math]::Max(0, $minX - $pad)
$cropY = [Math]::Max(0, $minY - $pad)
$cropW = [Math]::Min($src.Width - $cropX, ($maxX - $minX) + ($pad * 2))
$cropH = [Math]::Min($src.Height - $cropY, ($maxY - $minY) + ($pad * 2))

Write-Output "Crop rect: X=$cropX, Y=$cropY, W=$cropW, H=$cropH"

$rect = New-Object System.Drawing.Rectangle($cropX, $cropY, $cropW, $cropH)
$cropped = $src.Clone($rect, $src.PixelFormat)

$cropped.Save($dstPath, [System.Drawing.Imaging.ImageFormat]::Png)

$src.Dispose()
$cropped.Dispose()

Write-Output "Successfully cropped and saved to $dstPath"
