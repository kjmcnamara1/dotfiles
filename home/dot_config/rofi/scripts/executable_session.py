#!/usr/bin/env -S uv run --script
#
# /// script
# requires-python = ">=3.13"
# dependencies = []
# ///


import os
import shlex
import subprocess
from typing import Literal

type ModeOption = Literal[
    "prompt",
    "message",
    "markup-rows",
    "urgent",
    "active",
    "delim",
    "no-custom",
    "use-hot-keys",
    "keep-selection",
    "keep-filter",
    "new-selection",
    "data",
    "theme",
]

# type RowOption = Literal[
#     "icon",
#     "display",
#     "meta",
#     "nonselectable",
#     "permanent",
#     "info",
#     "urgent",
#     "active",
# ]


def write_mode(option: ModeOption, value: str):
    """
    Write a mode option and its value to stdout in Rofi script format.

    This function outputs a null-separated option and a value separated by
    a file separator character (0x1f), which is used for communication with
    Rofi (the window switcher, run dialog, and dmenu replacement).

    Args:
        option (ModeOption): The mode option to write.
        value (str): The value associated with the mode option.
    """
    print(f"\0{option}\x1f{value}")


def write_row(label: str, subtext: str = "", **options: str):
    row = f"""{label}\r<span foreground='gray' size='small'><i>{subtext}</i></span>"""
    for key, val in options.items():
        row += f"\x1f{key}\x1f{val}"
    row = row.replace("\x1f", "\0", 1)
    print(row)


def main():
    if not (ROFI_RETV := os.environ.get("ROFI_RETV")):
        print("Please run this script through Rofi.")
        return

    if int(ROFI_RETV) > 0 and (command := os.environ.get("ROFI_INFO", "")):
        subprocess.Popen(  # Let rofi window close immediately
            shlex.split(command),
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        return

    # Rofi Options
    write_mode("prompt", " 󰍂 ")
    write_mode("markup-rows", "true")
    write_mode(
        "theme",
        "entry {placeholder: 'Session Control';} "
        "window {width: 400px;} "
        "listview {scrollbar: false;}",
    )

    # List Items
    write_row(
        "Lock",
        "Hyprlock",
        icon="system-lock-screen",
        info="systemctl --user start hyprlock",
    )
    write_row(
        "Suspend",
        "Sleep",
        icon="system-suspend",
        info="systemctl suspend",
        meta="sleep",
    )
    write_row(
        "Log Out",
        "Exit Hyprland",
        icon="system-log-out",
        info="hyprctl dispatch exit",
        meta="exit",
    )
    write_row(
        "Hibernate",
        "DOESN'T WORK!",
        icon="system-hibernate",
        info="systemctl hibernate",
    )
    write_row(
        "Reboot",
        "Restart",
        icon="system-reboot",
        info="systemctl reboot",
        meta="restart",
    )
    write_row(
        "Shutdown",
        "Power Off",
        icon="system-shutdown",
        info="systemctl poweroff",
        meta="off",
    )


if __name__ == "__main__":
    main()
