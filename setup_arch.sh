#!/usr/bin/env bash

DRY_RUN=false

while getopts 'd' opt; do
  case $opt in
    d) DRY_RUN=true ;;
    *) echo 'Error in command line parsing' >&2
      exit 1
  esac
done

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

# get path of current file
DOTFILE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $DOTFILE_DIR

# Function to create symlinks between files and directories in 'dotfiles' repo and HOME directory
create_link () {
  # enabled=false

  local target="$PWD/$1"
  local link="$HOME/$1"

  if $DRY_RUN ; then
    echo "link = $link"
    echo "target = $target"
    echo
  else
    # first remove link if it already exists as a directory
    [[ -d $link ]] && rm -rf $link && echo "deleted directory at $link"
    # force create directory (also works for regular files) symlink to dotfile
    ln -sdf $target $link && echo "created symlink at $link" || echo "ERROR: failed to create symlink to $target"
  fi
}

# loop thru all items cwd
for item in $(ls -A); do
  # skip item if present in ignore array
  [[ ${IGNORE_ITEMS[@]} =~ $item ]] && continue

  # check if item is a directory and already exists in the HOME dir
  if [[ -d $item ]] && [[ -d "$HOME/$item" ]]; then
    # create symlinks for child items
    for subitem in $(ls -A $item); do
      create_link "$item/$subitem"
    done
  else
    create_link $item
  fi
done
