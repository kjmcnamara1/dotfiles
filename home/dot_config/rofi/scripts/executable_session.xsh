#!/usr/bin/env xonsh

import shlex
import subprocess
import re

if "ROFI_RETV" not in ${...}:
    # If Rofi is not calling this script, just exit.
    echo "Not ROFI!"
    # exit(0)

# ModeOption = Literal[
#     "prompt",
#     "message",
#     "markup-rows",
#     "urgent",
#     "active",
#     "delim",
#     "no-custom",
#     "use-hot-keys",
#     "keep-selection",
#     "keep-filter",
#     "new-selection",
#     "data",
#     "theme",
# ]

# RowOption = Literal[
#     "icon",
#     "display",
#     "meta",
#     "nonselectable",
#     "permanent",
#     "info",
#     "urgent",
#     "active",
# ]


def write_mode(option: str, value: str):
    """Write a mode option for Rofi."""
    print(f"\0{option}\x1f{value}")


def write_row(label: str, subtext: str = "", **options: str):
    """Write a row for Rofi with optional properties."""
    row = f"""{label}\r<span foreground='gray' size='small'><i>{
        subtext}</i></span>"""
    for key, val in options.items():
        row += f"\x1f{key}\x1f{val}"
    row = re.sub('\x1f', '\0', row, count=1)
    print(row)


match $ROFI_RETV:
    case "0":
        # Initial run
        write_mode("prompt", " 󰍂 ")
        # write_mode("message", "Session Control")
        write_mode("markup-rows", "true")
        write_mode(
            "theme", "entry {placeholder: 'Select...'; } " "window {width: 400px;}")
        write_row("Lock", "Hyprlock", icon="system-lock-screen",
                  info="uwsm-app -- hyprlock")
        write_row("Suspend", "Sleep", icon="system-suspend",
                  info="systemctl suspend", meta="sleep")
        write_row("Log Out", "Exit Hyprland", icon="system-log-out",
                  info="hyprctl dispatch exit", meta="exit")
        write_row("Hibernate", "DOESN'T WORK!", icon="system-hibernate",
                  info="systemctl hibernate")
        write_row("Reboot", "Restart", icon="system-reboot",
                  info="systemctl reboot",  meta="restart")
        write_row("Shutdown", "Power Off", icon="system-shutdown",
                  info="systemctl poweroff", meta="off")
    case "1":
        # Option selected
        if "ROFI_INFO" in ${...}:
            # @$(echo $ROFI_INFO) > /dev/null
            # subprocess.run(shlex.split($ROFI_INFO), stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            subprocess.Popen(shlex.split($ROFI_INFO), stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
