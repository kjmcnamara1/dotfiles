import sys
import logging
import warnings
import platform
import tempfile

warnings.filterwarnings("ignore", category=DeprecationWarning)

# Fix error when setting up logging.basicConfig
logging.getLogger("asyncio").setLevel(logging.WARNING)

# Xontribs
xontrib load coreutils vox
xontrib load abbrevs
xontrib load back2dir
xontrib load prompt_starship
xontrib load fish_completer
xontrib load hist_navigator # keymaps are broken (a-left, a-right, a-up)
xontrib load term_integration
# xontrib load kitty # allow printing mpl plots in terminal
# NOTE: check out https://github.com/xxh/xxh

# Environment Variables
if platform.system() == "Windows":
    $HOME = $(echo $HOMEPATH)
$CASE_SENSITIVE_COMPLETIONS = ''
$CMD_COMPLETIONS_SHOW_DESC = True
$DOTGLOB = True
$VI_MODE = True
$XONSH_AUTOPAIR = True
$XONSH_CTRL_BKSP_DELETION = True
$XONSH_HISTORY_MATCH_ANYWHERE = True
$YAZI_CONFIG_HOME = '~/.config/yazi'
$EDITOR = 'nvim'
$MANROFFOPT = '-c'
$MANPAGER = 'sh -c "col -bx | bat -l man -p"'
$PATH.prepend('~/.local/bin') # User binaries

# Allow python to import modules from cwd
sys.path.append('')

# Carapace Completion
$CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
$COMPLETIONS_CONFIRM=True
exec($(carapace _carapace))

# Zoxide
execx($(zoxide init --cmd cd xonsh), 'exec', __xonsh__.ctx, filename='zoxide')

# TODO: set up fzf integration

# Abbreviations
abbrevs['mkdir'] = 'mkdir -p'

# Aliases
aliases['c'] = 'clear' # Clear screen
aliases['p'] = 'paru' # Paru
aliases['py'] = 'python3' # Python
aliases['hx'] = 'helix' # Helix text editor
aliases['ff'] = 'fastfetch' # Fastfetch terminal sysinfo viewer
aliases['lg'] = 'lazygit' # Lazygit
aliases['cz'] = 'chezmoi' # Chezmoi dotfiles manager
aliases['schezmoi'] = 'sudo chezmoi --destination / --source ~/.local/share/chezmoi/root --working-tree ~/.local/share/chezmoi/root --config ~/.config/chezmoi/chezmoi.toml'
aliases['scz'] = 'schezmoi'
aliases['lvim'] = '''![$NVIM_APPNAME='nvim-lazyvim' nvim]''' # LazyVim
aliases['l'] = 'eza -F --icons --links --group-directories-first --git --git-repos --smart-group --hyperlink' # horizontal grid
aliases['ls'] = 'l -1' # single column list
aliases['la'] = 'ls -A' # all but . and ..
aliases['l.'] = r"la -d @$(eza -a | grep -e '^[.]')" # show only hidden files
aliases['ll'] = 'la -l' # long list including hidden
aliases['llr'] = 'll --time-style=relative' # long list with relative time
aliases['lt'] = 'll --tree --total-size' # long list and recurse into directories as tree
aliases['ltt'] = 'lt --level=2' # default tree list level 2
aliases['lttt'] = 'lt --level=3' # default tree list level 3
aliases['ltttt'] = 'lt --level=4' # default tree list level 4
aliases['lttttt'] = 'lt --level=5' # default tree list level 5
aliases['df'] = 'df -h' # human readable disk free
aliases['du'] = 'du -h' # human readable disk usage
# aliases['ls'] = 'ls -hv --color=auto --group-directories-first' # classify files in colour
# aliases['l'] = '/usr/bin/ls -hv --color=auto --group-directories-first' # shorthand plain ls
aliases['dc'] = 'docker compose' # Docker compose

# Yazi wrapper
@aliases.register
def _y(args):
    with tempfile.NamedTemporaryFile(prefix="yazi-cwd.") as tmp:
        yazi @(args) --cwd-file=@(tmp.name)
        cwd = tmp.read().decode("utf-8")
        if cwd != '' and cwd != $PWD:
            cd @(cwd)
