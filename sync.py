#!/usr/bin/env python3
import argparse
import logging
import sys
from pathlib import Path
from typing import Any

import tomllib

log = logging.getLogger(__name__)

DOTFILES = Path(__file__).resolve().parent
# DATA = DOTFILES / "data"
# IGNORE = (DOTFILES / "ignore").read_text().splitlines()
# LINKS = (DOTFILES / "links").read_text().splitlines()


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
    link.symlink_to(target, target.is_dir())


def prompt(msg: str, opts: list[str], default: int = 0, force: bool = False):
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
    text = f"{msg} [{'/'.join(opts)}] "
    opts = [o.casefold() for o in opts]

    result = input(text).casefold().strip()
    if result not in opts:
        return opts[default]
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
    default_options = {
        # "option_file": Path("sync_options.toml"),
        "dry_run": False,
        "force": False,
        "log": "WARNING",
        "link_dir": Path.home(),
        "target_dir": DOTFILES / "data",
        "ignore": [],
        "link": ["*"],
    }

    def options(option_file: str) -> dict[str, Any]:
        # print(option_file)
        try:
            option_path = Path(option_file)
            opts = tomllib.loads(option_path.read_text()) | {"file": option_path}
        except OSError:
            opts = {"file": None}

        opts["link_dir"] = Path(  # type: ignore
            opts.get("link_dir", default_options["link_dir"])  # type: ignore
        ).resolve()
        opts["target_dir"] = Path(  # type: ignore
            opts.get("target_dir", default_options["target_dir"])  # type: ignore
        ).resolve()

        # print(opts)
        # opts = default_options | opts
        # opts = argparse.Namespace(**opts)

        # print(opts)

        return default_options | opts

    parser = argparse.ArgumentParser(
        description="Sync dotfiles directory to another directory (i.e. $HOME)"
    )
    parser.add_argument(
        "-o",
        "--options",
        # dest="option_file",
        type=options,
        default="sync_options.toml",
        # type=Path,
        # default=default_options["option_file"],
        help="TOML file containing command line options [log, link_dir, target_dir, ignore, link]",
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
        # default=default_options["log"],
        help="Set logging level",
    )
    parser.add_argument(
        "--link-dir",
        type=Path,
        # default=default_options["link_dir"],
        help="Directory to place links in.",
    )
    parser.add_argument(
        "--target-dir",
        type=Path,
        # default=default_options["link_dir"],
        help="Directory containing target files.",
    )
    parser.add_argument(
        "-i",
        "--ignore",
        nargs="+",
        # default=default_options["ignore"],
        help="List of globs to ignore.",
    )
    parser.add_argument(
        "-l",
        "--link",
        nargs="+",
        # default=default_options["link"],
        help="List of globs to link.",
    )

    args = parser.parse_args()
    # print(f"initial args = {args}")

    # args.options = argparse.Namespace(**tomllib.loads(args.option_file.read_text()))
    # args.options = argparse.Namespace(**tomllib.load(args.option_file))

    # print(args.options.resolve())

    args.log = args.log or args.options["log"]
    args.link_dir = args.link_dir or args.options["link_dir"]
    args.target_dir = args.target_dir or args.options["target_dir"]
    args.ignore = args.ignore or args.options["ignore"]
    args.link = args.link or args.options["link"]

    # print(f"final args = {args}")

    return args


def main():
    args = parse_args()

    logging.basicConfig(level=args.log)

    log.debug("ARGS:")
    log.debug("option_file = %s", args.options["file"])
    log.debug("dry_run = %s", args.dry_run)
    log.debug("force = %s", args.force)
    log.debug("log = %s", args.log)
    log.debug("link_dir = %s", args.link_dir)
    log.debug("target_dir = %s", args.target_dir)
    log.debug("ignore = %s", args.ignore)
    log.debug("link = %s\n", args.link)

    # sys.exit()

    if args.dry_run:
        print("*** DRY RUN ***")

    print("Creating symlinks in", args.link_dir, "->", args.target_dir)
    print()

    # sys.exit()
    sync(
        target_dir=args.target_dir,
        link_dir=args.link_dir,
        dry_run=args.dry_run,
        force=args.force,
        ignore=args.ignore,
        to_link=args.link,
    )


if __name__ == "__main__":
    main()
