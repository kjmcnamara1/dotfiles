if status is-interactive # connected to keyboard
    # Commands to run in interactive sessions can go here

    # Plugins
    # fisher plugin manager
    # curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
    # fisher install oh-my-fish/plugin-sudope
    # fisher install acomagu/fish-async-prompt

    # TODO: Custom fastfetch for fish greeting
    # use std for opening new wezterm window

    # function fish_greeting
    #     fastfetch
    # end

    # VI Mode
    fish_vi_key_bindings
    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore
    set fish_cursor_replace underscore
    set fish_cursor_external line
    set fish_cursor_visual block
    set fish_vi_force_cursor 1

    bind -M insert \eh backward-char
    bind -M insert \el forward-char
    bind -M insert \ej down-or-search
    bind -M insert \ek up-or-search

    # Use <c-u> instead
    # <c-c> clears the commandline when in insert mode
    bind --mode insert \cc __fish_toggle_comment_commandline
    bind \cc __fish_toggle_comment_commandline

    # Environment Variables
    fish_add_path -g ~/.local/bin

    # Zoxide
    zoxide init --cmd cd fish | source

    # Set up fzf key bindings
    fzf --fish | source
    set -gx FD_OPTIONS "--exclude .git --exclude node_modules"
    set -gx FZF_DEFAULT_COMMAND "git ls-files --cached --others --exclude-standard | fd $FD_OPTIONS"
    set -gx FZF_DEFAULT_OPTS "--multi --reverse --height 50% --preview='bat --color=always {}' --preview-window='right:hidden' --bind='f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up'"
    # set -gx FZF_CTRL_T_COMMAND "fd --type f --type l $FD_OPTIONS"
    # set -gx FZF_CTRL_T_OPTS ""
    # set -gx FZF_ALT_C_COMMAND "fd --type d $FD_OPTIONS"
    # TODO: finish configuring fzf

    # Starship Prompt
    function starship_transient_prompt_func
        starship module line_break
        starship module directory
        starship module line_break
        starship module character
    end
    # source $HOME/.config/starship/starship.fish
    starship init fish | source
    enable_transience

    # Abbreviations
    abbr --add mkdir mkdir -p

    # Aliases
    alias c=clear # Clear screen
    alias p=paru # Paru
    alias py=python3 # Python
    alias ipy=ipython # Interactive Python Shell
    alias hx=helix # Helix text editor
    alias ff=fastfetch # Fastfetch terminal sysinfo viewer
    alias lg=lazygit
    alias cz=chezmoi # Chezmoi dotfiles manager
    alias schezmoi='sudo chezmoi --destination / --source ~/.local/share/chezmoi/root --working-tree ~/.local/share/chezmoi/root --config ~/.config/chezmoi/chezmoi.toml'
    alias scz=schezmoi
    alias wal='wallust pywal'
    alias lvim='set -lx NVIM_APPNAME nvim-lazyvim; nvim'
    alias l='eza -F --icons --links --group-directories-first --git --git-repos --smart-group --hyperlink' # horizontal grid
    alias ls='l -1' # single column list
    alias la='ls -A' # all but . and ..
    alias l.='la -d $(eza -a | grep -e \'^[.]\')' # show only hidden files
    alias ll='la -l' # long list including hidden
    alias llr='ll --time-style=relative' # long list with relative time
    alias lt='ll --tree --total-size' # long list and recurse into directories as tree
    alias ltt='lt --level=2' # default tree list level 2
    alias lttt='lt --level=3' # default tree list level 3
    alias ltttt='lt --level=4' # default tree list level 4
    alias lttttt='lt --level=5' # default tree list level 5
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

    # TODO: write function for sudo chezmoi that manages root files
    # https://github.com/twpayne/chezmoi/discussions/1510#discussioncomment-2627391

end
