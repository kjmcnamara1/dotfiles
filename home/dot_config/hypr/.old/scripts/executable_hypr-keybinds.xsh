#!/usr/bin/env xonsh

# A script to display Hyprland keybindings defined in your configuration
# using walker for an interactive search menu.

import subprocess
import json

# def get_keybinds() -> list[dict]:
#     try:
#         output = subprocess.check_output(["hyprctl", "binds", "-j"])
#         return json.loads(output)
#     except Exception as e:
#         print("Warning: Failed to get bind list due to:", e)
#         return json.loads("{}")

MODMASKS = {
    1: "SHIFT",
    4: "CTRL",
    5: "CTRL+SHIFT",
    8: "ALT",
    9: "ALT+SHIFT",
    12: "CTRL+ALT",
    13: "CTRL+ALT+SHIFT",
    64: "SUPER",
    65: "SUPER+SHIFT",
    68: "SUPER+CTRL",
    69: "SUPER+CTRL+SHIFT",
    72: "SUPER+ALT",
    73: "SUPER+ALT+SHIFT",
    76: "SUPER+CTRL+ALT",
    77: "SUPER+CTRL+ALT+SHIFT",
    0: "",
}


def read_raw_keybinds() -> list[dict]:
    try:
        output = subprocess.check_output(["hyprctl", "binds", "-j"])
        return json.loads(output)
    except Exception as e:
        print("Warning: Failed to get bind list due to:", e)
        return json.loads("[]")


def remove_submap_resets(binds: list[dict]) -> list[dict]:
    return [
        bind
        for bind in binds
        if not (bind["dispatcher"] == "submap" and bind["arg"] == "reset")
    ]


def format_modmask(modmask: int) -> str:
    return MODMASKS.get(modmask, f"MOD_{modmask}")


def format_keybind(bind: dict) -> str:
    modmask_str = format_modmask(bind["modmask"])
    # submap_str = format_keybind()
    return f"{bind['submap']:<10}{modmask_str:<20}{bind['key']:<30}{bind['description']}\t {bind['dispatcher']} {bind['arg']}"


def get_submaps(binds: list[dict]) -> dict[str, dict]:
    return {
        bind["arg"]: bind
        for bind in binds
        if bind["dispatcher"] == "submap" and bind["arg"] != "reset"
    }


binds = json.loads($(hyprctl binds -j))
# print(json.dumps(binds, indent=2))

binds = [format_keybind(bind) for bind in read_raw_keybinds()]
print(*binds, sep="\n")

submaps = get_submaps(read_raw_keybinds())
submap_strs = [format_keybind(bind) for bind in submaps.values()]
# print(json.dumps(submaps, indent=2))
# print(*submap_strs, sep="\n")


# print([bind for bind in binds if bind['keycode'] != 0])
