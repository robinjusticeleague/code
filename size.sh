#!/bin/bash

# --- Configuration ---
DIR_ICON="📁"
FILE_ICON="📄"

# --- Define size thresholds in bytes ---
KB=1024
MB=$((1024 * KB))
GB=$((1024 * MB))
TB=$((1024 * GB))

# --- Reusable function to format byte size into a human-readable string ---
format_size() {
    local size_bytes=$1
    local size_formatted
    local unit

    if (( size_bytes >= TB )); then
        size_formatted=$(awk -v size="$size_bytes" 'BEGIN {printf "%.2f", size / (1024*1024*1024*1024)}')
        unit="TB"
    elif (( size_bytes >= GB )); then
        size_formatted=$(awk -v size="$size_bytes" 'BEGIN {printf "%.2f", size / (1024*1024*1024)}')
        unit="GB"
    elif (( size_bytes >= MB )); then
        size_formatted=$(awk -v size="$size_bytes" 'BEGIN {printf "%.2f", size / (1024*1024)}')
        unit="MB"
    else
        size_formatted=$(awk -v size="$size_bytes" 'BEGIN {printf "%.2f", size / 1024}')
        unit="KB"
    fi

    echo "$size_formatted $unit"
}

# --- Main Logic ---
declare -a items_data
total_size_bytes=0

# 1. Loop through all top-level items to gather data and calculate total size.
for item in *; do
    [ ! -e "$item" ] && continue

    size_bytes=$(du -sb -- "$item" | awk '{print $1}')
    ((total_size_bytes += size_bytes))
    
    item_type="file"
    if [ -d "$item" ]; then
        item_type="dir"
    fi
    
    items_data+=("$size_bytes\t$item_type\t$item")
done

# 2. Sort the collected data numerically in reverse order.
IFS=$'\n' sorted_items=($(sort -nr <(printf "%s\n" "${items_data[@]}")))
unset IFS

# 3. Print a formatted header for the output.
printf "%-12s %s\n" "Size" "Item"
printf "%-12s %s\n" "------------" "----------------------------------------"

# 4. Loop through the sorted data and print each item.
for item_line in "${sorted_items[@]}"; do
    size_bytes=$(echo -e "$item_line" | cut -f1)
    item_type=$(echo -e "$item_line" | cut -f2)
    name=$(echo -e "$item_line" | cut -f3-)

    icon=$FILE_ICON
    if [ "$item_type" == "dir" ]; then
        icon=$DIR_ICON
    fi

    formatted_size_string=$(format_size "$size_bytes")
    printf "%-12s %s %s\n" "$formatted_size_string" "$icon" "$name"
done

# 5. Print a final summary line with the total size.
printf "%-12s %s\n" "------------" "----------------------------------------"
total_formatted_string=$(format_size "$total_size_bytes")
printf "%-12s %s\n" "$total_formatted_string" "Total Size"
