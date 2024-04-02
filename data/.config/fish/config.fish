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

    # Pyenv
    pyenv init - | source

    # Zoxide
    zoxide init --cmd cd fish | source

    # Starship Prompt
    source $HOME/.config/starship/starship.fish
    # starship init fish | source
    enable_transience

    # Aliaes
    alias vim=nvim # Neovim
    alias vi=nvim # Neovim
    alias py=python3 # Python
    alias hx=helix # Helix text editor
    alias l='eza --icons -F -H --group-directories-first --git' # horizontal grid
    alias ls='l -1' # single column list
    alias la='ls -A' # all but . and ..
    alias ll='la -l' # long list including hidden
    alias df='df -h' # human readable disk free
    alias du='du -h' # human readable disk usage
    # alias ls='ls -hv --color=auto --group-directories-first' # classify files in colour
    # alias l='/usr/bin/ls -hv --color=auto --group-directories-first' # shorthand plain ls

end
