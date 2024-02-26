if status is-interactive
    # Commands to run in interactive sessions can go here
end

# <c-c> clears the commandline when in insert mode
bind --mode insert \cc 'commandline -r ""'

# set fish_vi_force_cursor

set EDITOR nvim

# Zoxide
zoxide init --cmd cd fish | source

# Starship Prompt
starship init fish | source

# VI Keybindings
fish_vi_key_bindings
