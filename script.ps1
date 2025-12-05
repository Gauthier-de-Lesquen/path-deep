$root = "C:\"
$deepestPath = ""
$maxDepth = 0

$processed = 0
$barSize = 20

Get-ChildItem -Path $root -Recurse -Directory -ErrorAction SilentlyContinue |
ForEach-Object {

    $processed++

    # Barre de progression basée uniquement sur la vitesse (incrément)
    # Ce n’est pas un pourcentage réel faute de total connu
    $percent = ($processed % 100)
    $filled = [math]::Floor($percent * $barSize / 100)
    $empty = $barSize - $filled
    $bar = "[" + ("#" * $filled) + (" " * $empty) + "]"

    Write-Host -NoNewline "`r$bar  dossiers traités : $processed"

    # Calcul profondeur
    $path = $_.FullName
    $depth = ($path.Split("\") | Where-Object { $_ -ne "" }).Count

    if ($depth -gt $maxDepth) {
        $maxDepth = $depth
        $deepestPath = $path
    }
}

Write-Host "`nTerminé."
Write-Host "Chemin le plus profond :"
Write-Host $deepestPath
Write-Host "Nombre de dossiers : $maxDepth"
