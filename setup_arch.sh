#!/usr/bin/env bash

# Glob * will also include hidden files, but no . and ..
GLOBIGNORE=".:.."

DRY_RUN=false

while getopts 'd' opt; do
    case $opt in
        d) DRY_RUN=true ;;
        *) echo 'Error in command line parsing' >&2
            exit 1
    esac
done

# Print 'DRY RUN' if -d flag is present
$DRY_RUN  && echo 'DRY RUN'

# List of files in dotfiles dir to not create symlinks for
IGNORE_ITEMS=(
    .git
    .vscode
    LICENSE
    README.md
    setup_arch.sh
    setup_win.ps1
)

# Get path of current file
DOTFILE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$DOTFILE_DIR" || exit 1

# Function to create symlinks between files and directories in 'dotfiles' repo and HOME directory
create_link () {
    local target="$PWD/$1"
    local link="$HOME/$1"

    if $DRY_RUN ; then
        echo "link = $link"
        echo "target = $target"
        echo
    else
        # First remove link if it already exists as a directory
        [[ -d $link ]] && rm -rf "$link" && echo "deleted directory at $link"
        # Force create directory (also works for regular files) symlink to dotfile
        ln -sdf "$target" "$link" && echo "created symlink at $link" || echo "ERROR: failed to create symlink to $target"
    fi
}

# Loop thru all items cwd
for item in *; do
    # Skip item if present in ignore array
    [[ ${IGNORE_ITEMS[@]} =~ $item ]] && continue

    # Check if item is a directory and already exists in the HOME dir
    if [[ -d $item ]] && [[ -d "$HOME/$item" ]]; then
        # Create symlinks for child items
        for subitem in "$item"/*; do
            create_link "$subitem"
        done
    else
        create_link "$item"
    fi
done
