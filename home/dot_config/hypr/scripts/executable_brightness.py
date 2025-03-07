#!/usr/bin/python
# /// script
# requires-python = ">=3.13"
# dependencies = [
#     "icecream",
# ]
# ///

import json
import subprocess
import sys
from dataclasses import dataclass
from typing import Self

# @dataclass
# class Display:
#     id: int | None
#     bus: str
#     connector: str
#     manufacturer: str
#     model: str
#     product: str
#     serial: str
#     year: int

#     @classmethod
#     def parse(cls, raw_display: str) -> Self:
#         display = {}
#         for line in raw_display.split("\n"):
#             if line.startswith("Invalid"):
#                 display["id"] = None
#             elif line.startswith("Display"):
#                 display["id"] = int(line.rsplit(None, 1)[-1])
#                 continue
#             data = [item.strip() for item in line.split(":", 1)]
#             match data:
#                 case ["I2C bus", bus]:
#                     display["bus"] = bus
#                 case ["DRM connector", connector]:
#                     display["connector"] = connector
#                 case ["Mfg id", manufacturer]:
#                     display["manufacturer"] = manufacturer
#                 case ["Model", model]:
#                     display["model"] = model
#                 case ["Product code", product]:
#                     display["product"] = product
#                 case ["Serial number", serial]:
#                     display["serial"] = serial
#                 case ["Manufacture year", year]:
#                     display["year"] = int(year.split(",", 1)[0].strip())
#                 case _:
#                     pass
#                     # print(f"{data = } not captured!")

#         return cls(**display)


def run_command(command: str) -> str:
    return (
        subprocess.run(command, shell=True, capture_output=True).stdout.decode().strip()
    )


# def parse_i2c_displays(output: str) -> list[Display]:
#     """Parse the output of `ddcutil detect` into a dictionary of I2C displays"""
#     displays = [Display.parse(display) for display in output.strip().split("\n\n")]
#     return [display for display in displays if display.id is not None]


# def get_display_id_by_serial(serial: str, displays: list[Display]) -> int | None:
#     for display in displays:
#         if display.serial == serial:
#             return display.id


active_monitor_id = json.loads(run_command("hyprctl activeworkspace -j")).get(
    "monitorID"
)

monitors = json.loads(run_command("hyprctl monitors -j"))

active_monitor_serial = [
    monitor["serial"] for monitor in monitors if monitor["id"] == active_monitor_id
][0]


# i2c_displays = parse_i2c_displays(
#     subprocess.run(["ddcutil", "detect"], capture_output=True).stdout.decode()
# )

# active_display_id = get_display_id_by_serial(active_monitor_serial, i2c_displays)

run_command(f"ddcutil -n {active_monitor_serial} setvcp 10 {sys.argv[1]}")
