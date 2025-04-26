# This script will run every time fish is started unless disabled via env var
[ "$DISABLE_BACK2DIR" ] && exit

# where to save cwd when exiting fish
set fish_most_recent_dir_file ~/.config/fish/fish_most_recent_dir

# change to most recent dir if it has been saved in file and is a directory
[ -f $fish_most_recent_dir_file ] && [ -d "$(cat $fish_most_recent_dir_file)" ] && cd "$(cat $fish_most_recent_dir_file)"

# write cwd to file every time fish exits
function __back2dir --on-event fish_exit
    echo $PWD >$fish_most_recent_dir_file
end
