if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Plugins
# fisher plugin manager
# curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
# fisher install oh-my-fish/plugin-sudope
# fisher install acomagu/fish-async-prompt


# <c-c> clears the commandline when in insert mode
bind --mode insert \cc 'commandline -r ""'

# set fish_vi_force_cursor

set EDITOR nvim

# Aliaes
alias vim=nvim
alias py=python3

# Zoxide
zoxide init --cmd cd fish | source

# Starship Prompt
starship init fish | source

# VI Mode
fish_vi_key_bindings
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore
set fish_cursor_external line
set fish_cursor_visual block
