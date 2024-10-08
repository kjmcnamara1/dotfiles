if status is-interactive # connected to keyboard
    # Commands to run in interactive sessions can go here

    # Plugins
    # fisher plugin manager
    # curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
    # fisher install oh-my-fish/plugin-sudope
    # fisher install acomagu/fish-async-prompt

    # VI Mode
    fish_vi_key_bindings
    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore
    set fish_cursor_replace underscore
    set fish_cursor_external line
    set fish_cursor_visual block

    bind -M insert \eh backward-char
    bind -M insert \el forward-char
    bind -M insert \ej down-or-search
    bind -M insert \ek up-or-search

    # set fish_vi_force_cursor

    # <c-c> clears the commandline when in insert mode
    bind --mode insert \cc 'commandline -r ""'

    # Zoxide
    zoxide init --cmd cd fish | source

    # Set up fzf key bindings
    fzf --fish | source

    # Starship Prompt
    source $HOME/.config/starship/starship.fish
    # starship init fish | source
    enable_transience

    # Aliases
    alias py=python3 # Python
    alias hx=helix # Helix text editor
    alias ff=fastfetch # Fastfetch terminal sysinfo viewer
    alias l='eza -F --icons --links --group-directories-first --git --git-repos --smart-group --hyperlink' # horizontal grid
    alias ls='l -1' # single column list
    alias la='ls -A' # all but . and ..
    alias ll='la -l' # long list including hidden
    alias llr='ll --time-style=relative' # long list with relative time
    alias ltt='ll --tree --total-size' # long list and recurse into directories as tree
    alias lt='ltt --level=2' # default tree list level 2
    alias df='df -h' # human readable disk free
    alias du='du -h' # human readable disk usage
    # alias ls='ls -hv --color=auto --group-directories-first' # classify files in colour
    # alias l='/usr/bin/ls -hv --color=auto --group-directories-first' # shorthand plain ls
    alias dc='docker compose'

    # Yazi Wrapper
    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            __zoxide_cd_internal -- "$cwd"
        end
        rm -f -- "$tmp"
    end


end
