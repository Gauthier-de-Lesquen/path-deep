#!/bin/bash

root="/"
deepestPath=""
maxDepth=0

processed=0
barSize=20

while IFS= read -r dir; do
    ((processed++))

    percent=$((processed % 100))
    filled=$((percent * barSize / 100))
    empty=$((barSize - filled))
    bar="["
    for ((i=0;i<filled;i++)); do bar+="#"; done
    for ((i=0;i<empty;i++)); do bar+=" "; done
    bar+="]"

    printf "\r%s  processed folders : %d" "$bar" "$processed"

    path="$dir"
    depth=$(echo "$path" | awk -F/ '{count=0; for(i=1;i<=NF;i++) if($i!="") count++; print count}')

    if (( depth > maxDepth )); then
        maxDepth=$depth
        deepestPath="$path"
    fi
done < <(find "$root" -type d 2>/dev/null)

echo -e "\nFinished."
echo "Deepest path :"
echo "$deepestPath"
echo "Number of directories: $maxDepth"
