
#!/bin/bash
# Name: Delete Small Files & Empty Dirs
# Description: Deletes files with no extension or .nfo/.url/.txt extensions smaller than 1KB, then removes empty directories

# Get the selected directory or use current directory if none selected
if [ $# -gt 0 ]; then
    target_dir="$1"
else
    target_dir="$PWD"
fi

# Change to the target directory
cd "$target_dir" || { echo "Failed to change to directory: $target_dir"; exit 1; }

echo "Starting cleanup in $(pwd)"

# Find and delete small files with no extension or specified extensions
echo "Finding and deleting small files..."
find . -type f \( -name "*.[nN][fF][oO]" -o -name "*.[uU][rR][lL]" -o -name "*.[tT][xX][tT]" -o ! -name "*.*" \) -size -1024c -exec rm -v {} \;

# Delete empty directories
echo "Removing empty directories..."
find . -type d -empty -delete -print

echo "Cleanup complete!"

# Display a notification
if command -v notify-send &> /dev/null; then
    notify-send "Cleanup Complete" "Removed small files and empty directories in $target_dir"
fi
