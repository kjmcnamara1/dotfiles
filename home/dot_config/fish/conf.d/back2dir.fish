set -q fish_most_recent_dir && [ -d "$fish_most_recent_dir" ] && cd "$fish_most_recent_dir"

function __back2dir --on-variable PWD
    set -U fish_most_recent_dir $PWD
end
