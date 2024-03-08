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

    # set fish_vi_force_cursor

    # <c-c> clears the commandline when in insert mode
    bind --mode insert \cc 'commandline -r ""'

    # Pyenv
    pyenv init - | source

    # Zoxide
    zoxide init --cmd cd fish | source

    # Starship Prompt
    function starship_transient_prompt_func
        set -fx STARSHIP_CMD_STATUS $status
        # set -fx STARSHIP_CONFIG ~/.config/starship/starship_transient.toml
        set -fx STARSHIP_CONFIG $HOME/.config/starship/starship_transient.toml
        starship prompt --terminal-width="$COLUMNS" --status=$STARSHIP_CMD_STATUS
        # starship module character
    end
    source $HOME/.config/starship/starship.fish
    # starship init fish | source
    enable_transience

    # Aliaes
    alias vim=nvim
    alias py=python3

end
