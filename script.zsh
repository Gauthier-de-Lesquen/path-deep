#!/bin/zsh

root="/"
deepestPath=""
maxDepth=0

processed=0
barSize=20

for dir in $(find "$root" -type d 2>/dev/null); do
    ((processed++))

    percent=$((processed % 100))
    filled=$((percent * barSize / 100))
    empty=$((barSize - filled))
    bar="["
    for ((i=1; i<=filled; i++)); do bar+="#"; done
    for ((i=1; i<=empty; i++)); do bar+=" "; done
    bar+="]"

    print -n "\r$bar  processed files : $processed"

    IFS='/' read -A parts <<< "$dir"
    depth=0
    for p in $parts; do
        [[ -n $p ]] && ((depth++))
    done

    if (( depth > maxDepth )); then
        maxDepth=$depth
        deepestPath="$dir"
    fi
done

echo "\nFinished."
echo "Deepest path :"
echo "$deepestPath"
echo "Number of directories: $maxDepth"
