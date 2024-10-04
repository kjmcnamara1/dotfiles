# Xontribs
xontrib load coreutils vox prompt_starship

# Environment Variables
$CASE_SENSITIVE_COMPLETIONS = ''
$CMD_COMPLETIONS_SHOW_DESC = True
$DOTGLOB = True
$VI_MODE = True
$XONSH_AUTOPAIR = True
$XONSH_CTRL_BKSP_DELETION = True
$XONSH_HISTORY_MATCH_ANYWHERE = True
$YAZI_CONFIG_HOME='~/.config/yazi'

# Zoxide
execx($(zoxide init --cmd cd xonsh), 'exec', __xonsh__.ctx, filename='zoxide')

# Aliases
aliases['py'] = 'python3' # Python
aliases['hx'] = 'helix' # Helix text editor
aliases['ff'] = 'fastfetch' # Fastfetch terminal sysinfo viewer
aliases['l'] = 'eza -F --icons --links --group-directories-first --git --git-repos --smart-group --hyperlink' # horizontal grid
aliases['ls'] = 'l -1' # single column list
aliases['la'] = 'ls -A' # all but . and ..
aliases['ll'] = 'la -l' # long list including hidden
aliases['llr'] = 'll --time-style=relative' # long list with relative time
aliases['ltt'] = 'll --tree --total-size' # long list and recurse into directories as tree
aliases['lt'] = 'ltt --level=2' # default tree list level 2
aliases['df'] = 'df -h' # human readable disk free
aliases['du'] = 'du -h' # human readable disk usage
# aliases['ls'] = 'ls -hv --color=auto --group-directories-first' # classify files in colour
# aliases['l'] = '/usr/bin/ls -hv --color=auto --group-directories-first' # shorthand plain ls
aliases['dc'] = 'docker compose' # Docker compose

@aliases.register
def _y(args):
    tmp = $(mktemp -t "yazi-cwd.XXXXXX")
    yazi @(args) --cwd-file=@(tmp)
    cwd = $(cat @(tmp))
    if cwd != '' and cwd != $PWD:
        cd @(cwd)
    rm -f -- @(tmp)
