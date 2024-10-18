#!/usr/bin/env python3


import argparse
import enum
import os
import subprocess
import tempfile
from pathlib import Path

BASE_CONFIG = "base"
CONFIG_SUFFIX = ".yaml"

CONFIG_DIR = "configs"
PROFILE_DIR = "profiles"
PLUGIN_DIR = "plugins"

DOTBOT_DIR = "dotbot"
DOTBOT_BIN = "bin/dotbot"

BASE_DIR: Path = Path(__file__).resolve().parent
META_DIR: Path = BASE_DIR / "meta"


class ansi(enum.StrEnum):
    BOLD = "\033[1m"
    END = "\033[0m"


def bold(text):
    return ansi.BOLD + text + ansi.END


def update_submodules(base_dir):
    os.chdir(base_dir)
    subprocess.run(
        [
            "git",
            "-C",
            base_dir,
            "submodule",
            "sync",
            "--quiet",
            "--recursive",
        ]
    )
    subprocess.run(
        [
            "git",
            "submodule",
            "update",
            "--init",
            "--recursive",
            base_dir,
        ]
    )


def parse_arguments():
    parser = argparse.ArgumentParser(description="Use dotbot to install dotfiles")

    parser.add_argument(
        "-p",
        "--profile",
        help="Profile to install. Defaults to empty profile.",
    )
    parser.add_argument("configs", nargs="*", help="Configurations to install")

    return parser.parse_args()


def main():
    args = parse_arguments()

    configs = get_all_configs(META_DIR, args)

    # print(f"{configs = }")

    update_submodules(BASE_DIR)

    base_config = Path(META_DIR, BASE_CONFIG + CONFIG_SUFFIX).read_text()

    # sys.exit()

    for config_name in configs:
        print()
        print(f"*** Configure {bold(config_name)}")

        try:
            config = Path(META_DIR, CONFIG_DIR, config_name + CONFIG_SUFFIX).read_text()
        except FileNotFoundError:
            print(
                f"Config {bold(config_name)} not found in {(META_DIR/CONFIG_DIR).relative_to(BASE_DIR)}! ...Skipping"
            )
            continue

        # print(f"{config = }")

        with tempfile.NamedTemporaryFile(
            mode="w+", encoding="utf-8", newline="\n"
        ) as config_file:
            # config_file.write(base_config)
            config_file.write(config)
            config_file.seek(0)

            cmd = [
                f"{META_DIR}/{DOTBOT_DIR}/{DOTBOT_BIN}",
                "-vv",
                "-d",
                BASE_DIR,
                "-c",
                config_file.name,
                "--plugin-dir",
                f"{META_DIR}/{PLUGIN_DIR}/*",
            ]

            # print(f"{cmd = }")
            # print(f"{config_file.name = }")

            subprocess.run(cmd)

        os.chdir(BASE_DIR)


def get_all_configs(meta_dir, args):
    configs = set(args.configs)
    if args.profile:
        configs |= set(
            Path(meta_dir, PROFILE_DIR, args.profile).read_text().splitlines()
        )

    return configs


if __name__ == "__main__":
    main()
