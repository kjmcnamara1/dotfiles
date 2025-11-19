#!/usr/bin/env -S uv run --script
#
# /// script
# requires-python = ">=3.13"
# dependencies = []
# ///


from __future__ import annotations

import json
import os
import shlex
import subprocess
from dataclasses import dataclass
from enum import Flag, show_flag_values  # type: ignore
from typing import Any, Callable

KEY_SUBSTITUTIONS = {
    "super": "",
    # "super": "󰘳",
    "alt": "󰘵",
    "ctrl": "󰘴",
    "shift": "󰘶",
    "space": "󱁐",
    "escape": "󱊷",
    "return": "󰌑",
    # "backspace": "󰁮",
    "backspace": "Bksp",
    "delete": "Del",
    "up": "↑",
    "down": "↓",
    "left": "←",
    "right": "→",
    "apostrophe": "'",
    "mouse:272": "󰍽 LMB",
    "mouse:273": "󰍽 RMB",
    "mouse:274": "󰍽 MMB",
    "mouse_down": "󰍽 Scroll Down",
    "mouse_up": "󰍽 Scroll Up",
    "xf86audioraisevolume": "󰕾",
    "xf86audiolowervolume": "",
    "xf86audiomute": "",
    "xf86audiomicmute": "",
    "xf86monbrightnessup": "󰃠",
    "xf86monbrightnessdown": "󰃞",
    "xf86audionext": "󰙡",
    "xf86audiopause": "",
    "xf86audioplay": "",
    "xf86audioprev": "󰙣",
    "xf86poweroff": "",
}

type RawBind = dict[str, Any]
type FormatFn = Callable[[KeybindLine], str]


class Mod(Flag):
    SHIFT = 1
    CTRL = 4
    ALT = 8
    SUPER = 64

    def format(self, reverse: bool = True, sep: str = " + ") -> str:
        mods = [Mod(mod).name or "UNKNOWN" for mod in show_flag_values(self)]
        if reverse:
            mods.reverse()
        return sep.join(mods)


@dataclass
class Keybind:
    submap: str
    modmask: Mod
    key: str
    description: str
    dispatcher: str
    arg: str

    def __post_init__(self):
        self.modmask = Mod(self.modmask)

    @property
    def is_submap(self) -> bool:
        return self.dispatcher == "submap" and self.arg != "reset"


@dataclass
class KeybindLine:
    keys: str
    description: str
    command: str

    def format(self, format_fn: FormatFn) -> str:
        return format_fn(self)


def get_raw_binds() -> list[RawBind]:
    try:
        output = subprocess.check_output(["hyprctl", "binds", "-j"])
        return json.loads(output)
    except Exception as e:
        print("Warning: Failed to get bind list due to:", e)
        return json.loads("[]")


def filter_bind_fields(binds: list[RawBind], fields: list[str]) -> list[RawBind]:
    return [{field: bind[field] for field in fields if field in bind} for bind in binds]


def generate_keybinds(raw_binds: list[RawBind]) -> list[Keybind]:
    return [
        Keybind(**bind)
        for bind in filter_bind_fields(raw_binds, list(Keybind.__dataclass_fields__))
    ]


def extract_submaps(binds: list[Keybind]) -> dict[str, Keybind]:
    return {bind.arg: bind for bind in binds if bind.is_submap}


def create_keystring(
    kb: Keybind,
    submaps: dict[str, Keybind],
    sm_sep: str = ", ",
    key_sep: str = " + ",
    mod_sep: str = " + ",
    mod_reverse: bool = True,
) -> str:
    keystring = kb.modmask.format(reverse=mod_reverse, sep=mod_sep)
    if keystring:  # only add key_sep if there are modifiers
        keystring += key_sep
    keystring += kb.key
    if kb.is_submap:
        keystring += sm_sep
    if kb.submap:  # prefix with keystring of submap
        keystring = (
            create_keystring(
                kb=submaps[kb.submap],
                submaps=submaps,
                sm_sep=sm_sep,
                key_sep=key_sep,
                mod_sep=mod_sep,
                mod_reverse=mod_reverse,
            )
            + keystring
        )
    return keystring


def write_mode(option: str, value: str):
    """Write a mode option for Rofi."""
    print(f"\0{option}\x1f{value}")


def substitute_keys(keystr: str) -> str:
    return " ".join(
        [KEY_SUBSTITUTIONS.get(word.casefold(), word) for word in keystr.split()]
    )


def format_basic(kbl: KeybindLine) -> str:
    return f"{kbl.keys:30} | {kbl.description:50} | {kbl.command}"


def format_rofi(kbl: KeybindLine, width: int = 80, replace_chars: bool = True) -> str:
    ret = substitute_keys(kbl.keys) if replace_chars else kbl.keys
    ret += kbl.description.rjust(width - len(ret))
    ret += f"\r<span foreground='gray' size='small'><i>{kbl.command}</i></span>"
    ret += f"\0info\x1f{kbl.command}"
    ret += f"\x1fmeta\x1f{kbl.keys}"
    return ret


def calculate_rofi_width(
    kbls: list[KeybindLine], replace_chars: bool = True, padding: int = 3
) -> int:
    return (
        max(
            len(
                (substitute_keys(kbl.keys) if replace_chars else kbl.keys)
                + kbl.description
            )
            for kbl in kbls
        )
        + padding
    )


def main():
    if not (rofi_status := os.environ.get("ROFI_RETV")):
        print("Please run this script through Rofi.")
        return

    if int(rofi_status) > 0 and (dispatch := os.environ.get("ROFI_INFO", "")):
        command = ["hyprctl", "dispatch"] + shlex.split(dispatch)
        subprocess.run(command, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        return

    raw_binds = get_raw_binds()
    keybinds = generate_keybinds(raw_binds)
    submaps = extract_submaps(keybinds)
    clean_binds = [bind for bind in keybinds if bind.dispatcher != "submap"]
    keybind_lines = [
        KeybindLine(
            keys=create_keystring(kb, submaps),
            description=kb.description,
            command=kb.dispatcher + " " + kb.arg,
        )
        for kb in clean_binds
    ]
    rofi_width = calculate_rofi_width(keybind_lines)

    write_mode("prompt", " ⌨ ")
    write_mode("markup-rows", "true")
    write_mode(
        "theme",
        "entry { placeholder: 'Hyprland Keybinds'; }"
        f"window {{ width: {rofi_width + 13}ch; }} ",
        # "element-icon { enabled: false; }"
    )
    # print("\0theme\x1fwindow { width: 600px;}")
    for kbl in keybind_lines:
        print(format_rofi(kbl, rofi_width))


if __name__ == "__main__":
    main()
