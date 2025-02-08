set fish_most_recent_dir_file ~/.config/fish/fish_most_recent_dir

[ -f $fish_most_recent_dir_file ] && [ -d "$(cat $fish_most_recent_dir_file)" ] && cd "$(cat $fish_most_recent_dir_file)"

function __back2dir --on-event fish_exit
    echo $PWD >$fish_most_recent_dir_file
end
