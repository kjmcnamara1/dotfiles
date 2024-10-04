#!/usr/bin/env python3
import argparse
import logging
import os
import tomllib
from dataclasses import dataclass
from pathlib import Path
from typing import Any

log = logging.getLogger(__name__)

IS_WINDOWS = os.name == "nt"
DOTFILES_DIR = Path(__file__).resolve().parent
MODULES_DIR = DOTFILES_DIR / "modules"
PROFILES_FILE = DOTFILES_DIR / "profiles.toml"
# IGNORE = (DOTFILES / "ignore").read_text().splitlines()
# LINKS = (DOTFILES / "links").read_text().splitlines()

# TODO: Add ability to ignore files in module .sync.toml


def read_profiles() -> dict[str, Any]:
    return tomllib.loads(PROFILES_FILE.read_text()) if PROFILES_FILE.exists() else {}


def get_modules(profile_name: str, profiles: dict[str, Any]) -> set[str]:
    # [x]: Create set of modules from toml array and subtract modules starting with '!'
    if profile_name == "default":
        return set(
            module_path.name
            for module_path in MODULES_DIR.iterdir()
            if module_path.is_dir()
        )

    profile = profiles.get(profile_name)
    if profile is None:
        raise KeyError(f"Profile '{profile_name}' not found in {PROFILES_FILE}")

    raw_modules = set(profile.get("modules", []))
    add_modules = {module for module in raw_modules if not module.startswith("!")}

    # included_profiles = set(profile.get("include", []))
    for included_profile in set(profile.get("include", [])):
        add_modules.update(get_modules(included_profile, profiles))

    remove_modules = {module[1:] for module in raw_modules if module.startswith("!")}

    return add_modules - remove_modules


@dataclass(frozen=True)
class SyncModule:
    name: str

    @property
    def path(self) -> Path:
        return MODULES_DIR / self.name

    @property
    def destination(self) -> Path | None:
        _destination = (
            self._get_windows_destination()
            if IS_WINDOWS
            else self._get_unix_destination() or self._get_destination()
        )
        return (
            os.path.expandvars(Path(_destination).expanduser())
            if _destination
            else None
        )

    def _get_unix_destination(self) -> str | None:
        return self._read_module_options().get("unix_destination")

    def _get_windows_destination(self) -> str | None:
        return self._read_module_options().get("windows_destination")

    def _get_destination(self) -> str | None:
        return self._read_module_options().get("destination")

    def _read_module_options(self) -> dict[str, Any]:
        module_sync_file = self.path / ".sync.toml"
        return (
            tomllib.loads(module_sync_file.read_text())
            if module_sync_file.exists()
            else {}
        )

    def sync_to(self, destination: Path, dry_run: bool, force: bool):
        abs_targets = [file for file in self.path.rglob("*") if file.is_file()]

        for target in abs_targets:
            if target.name == ".sync.toml":
                continue

            log.debug("target = %s", target)

            rel_target = target.relative_to(self.path)
            link = destination / rel_target
            if is_dead_link(link):
                delete(link, dry_run)
            if not link.exists(follow_symlinks=False):
                symlink(link, target, dry_run)
                continue

            # link does exist
            if link.samefile(target):
                log.info("%s is the same file as %s ... skipping", link, target)
                continue

            result = prompt(
                f"File already exists at {link}. Which file would you like to keep?\n"
                f"[1] {target}\n"
                f"[2] {link}{f' ( -> {link.resolve()})' if link.is_symlink() else ''}\n"
                f"[S] Don't link this file\n",
                opts=["1", "2", "s"],
                default=-1,
                force=force,
                hide_opts=True,
            )
            # print(f"{result =}")

            match result:
                case "1":
                    delete(link, dry_run)
                    symlink(link, target, dry_run)
                case "2":
                    delete(target, dry_run)
                    move(link, target, dry_run)
                    symlink(link, target, dry_run)
                case _:
                    continue


def is_dead_link(path: Path) -> bool:
    return path.is_symlink() and not path.exists(follow_symlinks=True)


def delete(path: Path, dry_run: bool):
    log.info("Deleting %s", path)
    if dry_run:
        return
    if path.is_dir() and not path.is_symlink():
        path.rmdir()
    else:
        path.unlink()


def move(src: Path, dst: Path, dry_run: bool):
    """dst must not exist"""
    # if dst.exists(follow_symlinks=False):
    #     overwrite = prompt(f"{dst} exists. Overwrite?", ["y", "n"]) == "y"
    #     if not overwrite:
    #         print("Skipping", dst)
    #         delete(src, dry_run)
    #         return
    #     delete(dst, dry_run)
    log.info("Moving %s to %s", src, dst)
    if dry_run:
        return
    src.rename(dst)


def symlink(link: Path, target: Path, dry_run: bool):
    print(link, " -> ", target)
    if dry_run:
        return
    if link.parent.is_symlink():
        log.info("Removing symlink at %s", link.parent)
        link.parent.unlink()
    if not link.parent.exists():
        log.info("Creating directory at %s", link.parent)
        link.parent.mkdir(parents=True)
    link.symlink_to(target, target.is_dir())


def prompt(
    msg: str,
    opts: list[str],
    default: int = 0,
    force: bool = False,
    hide_opts: bool = False,
):
    """
    Prompt the user to select an option from a list of options

    Parameters:
    - msg: a string containing the message to prompt the user
    - opts: a list of strings containing the options for the user to choose from
    - default: an integer representing the index of the default option (default = 0)
    - force: a boolean flag to skip prompt and force the default option (default = False)

    Return:
    - a lowercase string of the valid input or the default option
    """
    opts = [str(o).casefold() for o in opts]
    if force:
        return opts[default]
    opts[default] = opts[default].upper()
    text = msg if hide_opts else f"{msg} [{'/'.join(opts)}] "
    opts = [o.casefold() for o in opts]

    result = input(text).casefold().strip()
    if result == "":
        result = opts[default]
    if result not in opts:
        result = input("Please enter a valid option: \n" + text).casefold().strip()
    return result


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Sync dotfiles directory to another directory (i.e. $HOME)"
    )

    # TODO: Add argument for providing modules directly
    parser.add_argument(
        "-p",
        "--profile",
        default="default",
        help="Profile to sync. If not specified, default profile will sync all modules.",
    )
    parser.add_argument(
        "--destination",
        type=Path,
        default=Path.home(),
        help="Directory to place links in. Defaults to home path.",
    )
    parser.add_argument(
        "-d",
        "--dry-run",
        action="store_true",
        help="Do not actually link, move, or delete files/folders.",
    )
    parser.add_argument(
        "-f",
        "--force",
        action="store_true",
        help="Do not prompt user. Automatically accept default option.",
    )
    parser.add_argument(
        "--log",
        choices=["DEBUG", "INFO", "WARNING", "ERROR", "CRITICAL"],
        default="WARNING",
        help="Set logging level",
    )

    return parser.parse_args()


def main():
    options = parse_args()

    logging.basicConfig(level=options.log)

    log.debug("ARGS:")
    for key, value in vars(options).items():
        log.debug("%s = %s", key, value)

    # sys.exit()

    if options.dry_run:
        print("\n*** DRY RUN ***\n")

    # TODO: use dataclass for Profile so 'default' profile works
    profiles = read_profiles()
    modules = get_modules(options.profile, profiles)
    for mod in modules:
        module = SyncModule(mod)
        destination = (
            module.destination
            or profiles[options.profile].get("destination")
            or options.destination
        )
        log.debug("module: %s", mod)
        log.debug("destination: %s", destination)
        module.sync_to(destination, dry_run=options.dry_run, force=options.force)


if __name__ == "__main__":
    main()
