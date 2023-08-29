#!/usr/bin/env bash

# This script merges files with the extensions .cfg and .txt from all directories in the current directory into a new directory called merged.
# For other file types, it will copy the file to the merged directory and rename it with a number affix if there are multiple files with the same name.

# Set error handling
set -euo pipefail

# Find all directories in the current directory
directories=$(find . -maxdepth 1 -type d)

# Print the name of the script
echo "$(tput setaf 3)🚀 TF2 Config Merger v1.2 🚀$(tput sgr0)"

# Print a list of all directories in the current directory
echo "$(tput setaf 3)📂 List of directories in the current directory: 📂$(tput sgr0)"
printf '%s\n' "$directories"

# Prompt the user to enter a name for the merged folder
read -p "$(tput setaf 3)📁 Enter a name for the merged folder: $(tput sgr0)" merged_folder

# Create a new directory to store the merged files
mkdir -p "$merged_folder"

# Print a message indicating that the merging process is starting.
echo "$(tput setaf 3)🔨 Merging, please wait... 🔨$(tput sgr0)"

# Create a log file
log_file="$merged_folder/merge.log"
touch "$log_file"

# Log the start time of the script
echo "[$(date)] Start merging" | tee -a "$log_file"

# Create a log file to record merged folders
merged_folders_log="merged_folders.log"
touch "$merged_folders_log"

# Prompt the user if they want to ignore folders that have already been merged.
echo "$(tput setaf 2)Ignoring folders that have already been merged can save time by not re-merging them.$(tput sgr0)"
echo "$(tput setaf 6)(y) If you choose to ignore already merged folders, this script will merge the previously merged folder with any new folders.$(tput sgr0)"
echo "$(tput setaf 5)(n) If you choose not to ignore the folders, this script will merge again all folders except previously merged folders that have been merged with this script.$(tput sgr0)"
read -p "$(tput setaf 3)📁 Do you want to ignore folders that have already been merged? (y/n): $(tput sgr0)" ignore_merged_folders

if [[ $ignore_merged_folders == "y" ]]; then
	ignore_merged_folders=true
else
	ignore_merged_folders=false
fi

# Loop through all directories
while IFS= read -r dir; do
	# Skip the current directory and the merged directory
	if [[ $dir == "." || $dir == "./$merged_folder" ]]; then
		continue
	fi

	# Check if the folder has already been merged by checking if its name and path are recorded in the log file.
	if $ignore_merged_folders && grep -Fxq "$dir" "$merged_folders_log"; then
		echo "[$(date)] Skipping $dir because it has already been merged." | tee -a "$log_file"
		continue
	fi

	# Find all files in the current directory
	while IFS= read -r file; do
		# Get the file name and extension
		filename=$(basename -- "$file")
		extension="${filename##*.}"

		# Get the relative path of the file within its directory
		relpath=$(realpath --relative-to="$dir" "$(dirname "$file")")

		# Create a new file in the merged directory with the same relative path and name
		if [[ -z $relpath ]]; then
			newfile="./$merged_folder/$filename"
		else
			newfile="./$merged_folder/$relpath/$filename"
		fi

		# Ensure that the new file path does not contain any double slashes or end with a slash
		newfile="${newfile//\/\///}"
		if [[ "${newfile: -1}" == "/" ]]; then
			newfile="${newfile::-1}"
		fi

		mkdir -p "$(dirname "$newfile")"

		# If the file is a .cfg or .txt file, merge it. Otherwise, copy it.
		if [[ $extension == "cfg" || $extension == "txt" ]]; then
			# If the file already exists, append to it. Otherwise, create a new file.
			if [[ ! -f $newfile ]]; then
				touch "$newfile"
			fi

			# Add a header with the Contents and Folder information before appending the contents of the file being merged.
			echo "// Contents: $filename, Folder: $dir" >> "$newfile"

			# Append the contents of the file being merged.
			cat "$file" >> "$newfile"

			# Add a new line at the end of adding the new file.
			echo "" >> "$newfile"

			echo "[$(date)] Merged $filename from $dir into $newfile" | tee -a "$log_file"
		else
			# If the file already exists, rename it with a number affix. Otherwise, copy it.
			if [[ -f $newfile ]]; then
				i=2
				while [[ -f "${newfile%.*}_$i.$extension" ]]; do
					i=$((i + 1))
				done
				cp "$file" "${newfile%.*}_$i.$extension"
				echo "[$(date)] Copied $filename from $dir to ${newfile%.*}_$i.$extension" | tee -a "$log_file"
			else
				cp "$file" "$newfile"
				echo "[$(date)] Copied $filename from $dir to $newfile" | tee -a "$log_file"
			fi
		fi
	done < <(find "$dir" -type f)

	# Record the name and path of the merged folder in the log file.
	echo "$dir" >> "$merged_folders_log"
done < <(printf '%s\n' "$directories")

# Log the end time of the script and print a message indicating that the merging process is done.
echo "[$(date)] Done merging files." | tee -a "$log_file"
echo "$(tput setaf 2)Done merging files.$(tput sgr0)"
read -n 1 -s -r -p "$(tput setaf 3)Press any key to close this window.$(tput sgr0)"
