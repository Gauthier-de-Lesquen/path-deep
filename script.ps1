$root = "C:\"
$deepestPath = ""
$maxDepth = 0

$processed = 0
$barSize = 20

Get-ChildItem -Path $root -Recurse -Directory -ErrorAction SilentlyContinue |
ForEach-Object {

    $processed++

    # Progress bar
    # not a real percentage
    $percent = ($processed % 100)
    $filled = [math]::Floor($percent * $barSize / 100)
    $empty = $barSize - $filled
    $bar = "[" + ("#" * $filled) + (" " * $empty) + "]"

    Write-Host -NoNewline "`r$bar  dossiers traités : $processed"

    # deep calculating
    $path = $_.FullName
    $depth = ($path.Split("\") | Where-Object { $_ -ne "" }).Count

    if ($depth -gt $maxDepth) {
        $maxDepth = $depth
        $deepestPath = $path
    }
}

Write-Host "`nFinished."
Write-Host "Deepest path :"
Write-Host $deepestPath
Write-Host "Number of directories: $maxDepth"
