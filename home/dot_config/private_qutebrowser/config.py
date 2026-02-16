from typing import TYPE_CHECKING
from qutebrowser.mainwindow import tabwidget

if TYPE_CHECKING:
    from qutebrowser.config.configfiles import ConfigAPI
    from qutebrowser.config.config import ConfigContainer

    config: ConfigAPI = config
    c: ConfigContainer = c

tabwidget.TabWidget.MUTE_STRING = "󰖁"
tabwidget.TabWidget.AUDIBLE_STRING = "󰕾"

config.source("nord-qutebrowser.py")

c.colors.webpage.darkmode.enabled = True
c.colors.webpage.preferred_color_scheme = "dark"

c.fonts.default_family = "JetBrainsMono Nerd Font"
c.fonts.default_size = "12pt"
c.fonts.tooltip = "default_size default_family"
c.fonts.web.family.fixed = "JetBrainsMono Nerd Font"

# c.auto_save.session = True
c.content.autoplay = False
c.scrolling.smooth = True
c.session.default_name = "default"
c.session.lazy_restore = True

c.url.default_page = "https://search.brave.com/"
c.url.start_pages = "https://search.brave.com"
c.url.open_base_url = True
c.url.searchengines = {
    "DEFAULT": "https://search.brave.com/search?q={}",
    "a": "https://archlinux.org/packages/?q={}",
    "aur": "https://aur.archlinux.org/packages?O=0&K={}",
    "az": "https://www.amazon.com/s?k={}",
    "bi": "https://www.bing.com/search?q={}",
    "g": "https://wwwgoogle.com/search?q={}",
    "g.m": "https://www.google.com/maps?q={}",
    "gh": "https://github.com/search?q={}",
    "py": "https://pypi.org/search/?q={}",
    "w": "https://www.wikipedia.org/w/index.php?search={}",
    "y": "https://www.youtube.com/results?search_query={}",
}

c.editor.command = ["kitty", "-e", "nvim", "{file}", "-c", "normal {line}G{column0}l"]
c.fileselect.folder.command = ["kitty", "-e", "yazi", "--chooser-file={}"]
c.fileselect.multiple_files.command = ["kitty", "-e", "yazi", "--chooser-file={}"]
c.fileselect.single_file.command = ["kitty", "-e", "yazi", "--chooser-file={}"]

c.tabs.show = "always"
c.tabs.position = "left"
c.tabs.select_on_remove = "last-used"
c.tabs.last_close = "close"
c.tabs.title.format = "{audio}"
c.tabs.title.format_pinned = "{index}{audio}"
c.tabs.width = 55
c.tabs.padding = {
    "left": 5,
    "right": 5,
    "top": 10,
    "bottom": 10,
}

# c.bindings.default = {}
c.bindings.commands["normal"] = {
    "<escape>": "clear-keychain ;; search ;; fullscreen --leave",
    ":": "cmd-set-text :",
    "/": "cmd-set-text /",
    "?": "cmd-set-text ?",
    ".": "cmd-repeat-last",
    "h": "cmd-run-with-count 3 scroll left",
    "j": "cmd-run-with-count 3 scroll down",
    "k": "cmd-run-with-count 3 scroll up",
    "l": "cmd-run-with-count 3 scroll right",
    "H": "back",
    "L": "forward",
    "J": "tab-next",
    "K": "tab-prev",
    "<alt+j>": "tab-move +",
    "<alt+k>": "tab-move -",
    "d": "tab-close",
    "<Ctrl+r>": 'config-source ;; message-info "Config reloaded!"',
    "M": "hint links spawn --detach mpv {hint-url}",
    "cm": "clear-messages",
    # " '": "tab-focus last",
    "<alt-9>": "tab-focus 9",
    "<alt-0>": "tab-focus -1",
}

c.bindings.commands["command"] = {
    "<return>": "command-accept",
    "<ctrl-return>": "command-accept --rapid",
    "<escape>": "mode-leave",
    "<alt-h>": "rl-backward-char",
    "<alt-l>": "rl-forward-char",
    "<ctrl-h>": "rl-backward-delete-char",
    "<ctrl-l>": "rl-delete-char",
    # "<alt-l>": "rl-backward-word",
    # "<alt-l>": "rl-forward-word",
    # "<alt-l>": "rl-beginning-of-line",
    # "<alt-l>": "rl-end-of-line",
    # "<alt-l>": "rl-unix-line-discard",
    # "<alt-l>": "rl-kill-line",
    # "<alt-l>": "rl-kill-word",
    # "<ctrl-w>": "rl-rubout ' '",
    # "<ctrl-shift-w>": "rl-filename-rubout",
    # "<alt-backspace>": "rl-backward-kill-word",
    # "<ctrl-y>": "rl-yank",
    "<alt-j>": "completion-item-focus --history next",
    "<alt-k>": "completion-item-focus --history prev",
    "<ctrl-d>": "completion-item-focus next-page",
    "<ctrl-u>": "completion-item-focus prev-page",
}

c.bindings.commands["insert"] = {
    "<escape>": "mode-leave ;; jseval -q document.activeElement.blur()",
    "<ctrl-e>": "edit-text",
}

c.bindings.commands["passthrough"] = {
    "<shift-escape>": "mode-leave",
}

c.bindings.commands["hint"] = {
    "<escape>": "mode-leave",
    "<return>": "hint-follow",
}


config.load_autoconfig()
