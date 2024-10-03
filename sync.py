#!/usr/bin/env python3
import argparse
import logging
import os
import tomllib
from dataclasses import dataclass, field
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


@dataclass
class SyncOptions:
    dry_run: bool = True
    force: bool = False
    log: str = "WARNING"
    destination: Path = Path.home()
    target_dir: Path = DOTFILES_DIR / "data"
    ignore: list[str] = field(default_factory=list)
    link: list[str] = field(default_factory=lambda: ["*"])


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
        return Path(_destination) if _destination else None

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
            rel_target = target.relative_to(self.path)
            link = destination / rel_target
            if not link.exists():
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
    if not link.parent.exists():
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


def consolidate(source: Path, destination: Path, dry_run: bool, force=False):
    # if dst is regular file or symlink(file or dir):
    #     if src is regular file:
    #         ask to overwrite
    #         if overwrite:
    #             delete dst then move src
    #         else:
    #             delete src
    #     if src is symlink(file or dir):
    #         delete src
    #     if src is regular dir:
    #         shouldn't happen
    # if dst is regular dir:
    #     if src is regular file:
    #         ask to overwrite
    #         if overwrite:
    #             delete dst then move src
    #     if src is symlink(file or dir):
    #         delete src
    #     if src is regular dir:
    #         consolidate each item in src to dst
    #         delete src
    # if dst is symlink(file or dir):
    #     if src is regular file:
    #         ask to overwrite
    #         if overwrite:
    #             delete dst then move src
    #     if src is symlink:
    #         delete src
    #     if src is regular dir:
    #         shouldn't happen

    log.debug('source = "%s", destination = "%s"', source, destination)

    if not source.exists(follow_symlinks=False):
        log.debug(f"{source} doesn't exist")
        return

    # If src is a regular file, ask to overwrite dst if dst exists
    # Then move src to dst
    if source.is_file() and not source.is_symlink():
        if destination.exists(follow_symlinks=False):
            overwrite = (
                prompt(f"{destination} exists. Overwrite?", ["y", "n"], 1, force) == "y"
            )
            if not overwrite:
                delete(source, dry_run)
                return
            delete(destination, dry_run)
        move(source, destination, dry_run)
        return

    # If both are regular directories, recursively consolidate each item in src to dst
    if (
        source.is_dir()
        and destination.is_dir()
        and not source.is_symlink()
        and not destination.is_symlink()
    ):
        for item in source.iterdir():
            dst_item = destination / item.name
            consolidate(item, dst_item, dry_run, force)

    # finished looping through items (empty dir)
    delete(source, dry_run)


def sync(
    target_dir: Path,
    link_dir: Path,
    dry_run: bool,
    force: bool,
    ignore: list[str],
    to_link: list[str],
):
    """Sync two existing directories with symlinks"""
    for target in target_dir.iterdir():
        # Immediately ignore any target matching 'ignore' file
        if any([target.match(glob) for glob in ignore]):
            print("Ignoring", target)
            continue  # next target

        link = link_dir / target.relative_to(target_dir)

        log.debug("link = %s, target = %s", link, target)

        # If target matches 'links' file, Consolidate link to target, then create symlink
        if any([target.match(glob) for glob in to_link]):
            # both link and target are normal dirs
            # if not link.is_symlink() and link.is_dir() and target.is_dir():

            # link and target could be anything -> handle in consolidate fn
            consolidate(link, target, dry_run, force)
            # after consolidate fn, link should not exist
            if not dry_run:
                assert not link.exists(
                    follow_symlinks=False
                ), f"{link} exists after consolidate"

            symlink(link, target, dry_run)
            continue  # next target

        # Target is not in ignore or link lists
        if target.is_file():
            log.info("Skipping %s", target)
            continue  # next target

        # Target is a directory
        log.info("Entering subdirectory %s", target)
        sync(
            target_dir=target,
            link_dir=link,
            dry_run=dry_run,
            force=force,
            ignore=ignore,
            to_link=to_link,
        )


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Sync dotfiles directory to another directory (i.e. $HOME)"
    )

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

    # print("Creating symlinks in", args.link_dir, "->", args.target_dir)
    # print()

    # loop through all modules in profile
    # create folders in destination that don't exist
    # check if file exists and ask whether to keep or overwrite with symlink
    # symlink files that don't exist

    profiles = read_profiles()
    # print(json.dumps(profiles["linux"], indent=2))
    modules = get_modules(options.profile, profiles)
    for mod in modules:
        module = SyncModule(mod)
        destination = (
            module.destination
            or profiles[options.profile].get("destination")
            or options.destination
        )
        module.sync_to(destination, dry_run=options.dry_run, force=options.force)

    # sys.exit()
    # sync(
    #     target_dir=args.target_dir,
    #     link_dir=args.link_dir,
    #     dry_run=args.dry_run,
    #     force=args.force,
    #     ignore=args.ignore,
    #     to_link=args.link,
    # )


if __name__ == "__main__":
    main()
