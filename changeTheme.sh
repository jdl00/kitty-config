#!/bin/bash

kitty_theme_dir="kitty-themes/themes"

# Get the current directory
directory="$(pwd)/$kitty_theme_dir"

# List all files in the current directory
files=()
while IFS= read -r -d $'\0' file; do
    files+=("$file")
done < <(find "$directory" -maxdepth 1 -type f -print0)

# Print the list of files with corresponding numbers
echo "Files in $directory:"
for ((i=0; i<${#files[@]}; i++)); do
    echo "$((i+1)). ${files[i]}"
done

# Prompt user to select a file
read -p "Enter the number of the file you want to select: " choice

# Check if the choice is a valid number
if [[ $choice =~ ^[0-9]+$ && $choice -ge 1 && $choice -le ${#files[@]} ]]; then
    selected_file="${files[choice-1]}"
    echo "You selected: $selected_file"
else
    echo "Invalid choice. Please enter a valid number."
fi


theme_conf="theme.conf"

# Check if theme.conf exists
if [ -e "$theme_conf" ]; then
    echo "Deleting $theme_conf..."
    rm "$theme_conf"
    echo "$theme_conf deleted."
else
    echo "$theme_conf does not exist creating theme file"
fi


ln -s $selected_file ~/.config/kitty/theme.conf
