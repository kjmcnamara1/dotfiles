#!/usr/bin/env zsh
# Add Poetry to PATH
export PATH="$HOME/.local/bin:$PATH"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# plugins=(
#   zsh-vi-mode
#   git
#   gh
#   gitignore
#   fzf
#   node
#   npm
#   python
#   poetry
#   sudo
#   dirhistory
#   z
#   zsh-autosuggestions
#   zsh-syntax-highlighting
#   ohmyzsh-full-autoupdate
#   )

# ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root line)
# ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')

# ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
# # Change to Zsh's default readkey engine
# ZVM_READKEY_ENGINE=$ZVM_READKEY_ENGINE_DEFAULT
# # Do the initialization when the script is sourced (i.e. Initialize instantly)
# ZVM_INIT_MODE=sourcing

# Transient Prompt
export ENABLE_TRANSIENT_PROMPT='true'

# Preferred editor
export EDITOR=nvim

# Aliases
alias ls='ls -hv --color=auto --group-directories-first' # classify files in colour
alias l='ls -l'                                          # non hidden list
alias ll='ls -Al'                                        # long list including hidden
alias la='ls -A'                                         # all but . and ..
alias df='df -h'                                         # human readable disk free
alias du='du -h'                                         # human readable disk usage
alias py='python3'

# Zoxide
eval "$(zoxide init --cmd cd zsh)"

# Starship Prompt
eval "$(starship init zsh)"

# Vim keybindings
bindkey -v
