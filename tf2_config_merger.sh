#!/bin/bash

# This script merges files with the extensions .cfg and .txt from all directories in the current directory into a new directory called merged.
# For other file types, it will copy the file to the merged directory and rename it with a number affix if there are multiple files with the same name.

# Find all directories in the current directory
directories=$(find . -maxdepth 1 -type d)

# Create a new directory to store the merged files
mkdir -p merged

# Loop through all directories
while IFS= read -r dir; do
	# Skip the current directory and the merged directory
	if [[ $dir == "." || $dir == "./merged" ]]; then
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
			newfile="./merged/$filename"
		else
			newfile="./merged/$relpath/$filename"
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
		else
			# If the file already exists, rename it with a number affix. Otherwise, copy it.
			if [[ -f $newfile ]]; then
				i=2
				while [[ -f "${newfile%.*}_$i.$extension" ]]; do
					i=$((i + 1))
				done
				cp "$file" "${newfile%.*}_$i.$extension"
			else
				cp "$file" "$newfile"
			fi
		fi
	done < <(find "$dir" -type f)
done < <(printf '%s\n' "$directories")

# Print a message indicating that the merging process is done.
echo "Done merging files."
