#!/usr/bin/env python3
import logging
import sys
from pathlib import Path

log = logging.getLogger(__name__)

DOTFILES = Path(__file__).resolve().parent
DATA = DOTFILES / "data"
IGNORE = (DOTFILES / "ignore").read_text().splitlines()
LINKS = (DOTFILES / "links").read_text().splitlines()


def delete(path: Path, dry_run: bool):
    log.info("Deleting %s", path)
    if dry_run:
        return
    if path.is_dir():
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


def prompt(msg: str, opts: list[str], default: int = 0):
    """
    Prompt the user to select an option from a list of options

    Parameters:
    - msg: a string containing the message to prompt the user
    - opts: a list of strings containing the options for the user to choose from
    - default: an integer representing the index of the default option (default = 0)

    Return:
    - a lowercase string of the valid input or the default option
    """
    opts = [str(o).casefold() for o in opts]
    opts[default] = opts[default].upper()
    text = f"{msg} [{'/'.join(opts)}] "
    opts = [o.casefold() for o in opts]

    result = input(text).casefold().strip()
    if result not in opts:
        return opts[default]
    return result


def consolidate(source: Path, destination: Path, dry_run: bool):
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
                prompt(f"{destination} exists. Overwrite?", ["y", "n"], 1) == "y"
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
            consolidate(item, dst_item, dry_run)

    # finished looping through items (empty dir)
    delete(source, dry_run)


def sync(target_dir: Path, link_dir: Path, dry_run: bool = False):
    """Sync two existing directories with symlinks"""
    for target in target_dir.iterdir():
        # Immediately ignore any target matching 'ignore' file
        if any([target.match(glob) for glob in IGNORE]):
            print("Ignoring", target)
            continue  # next target

        link = link_dir / target.relative_to(target_dir)

        log.debug("link = %s, target = %s", link, target)

        # If target matches 'links' file, Consolidate link to target, then create symlink
        if any([target.match(glob) for glob in LINKS]):
            # both link and target are normal dirs
            # if not link.is_symlink() and link.is_dir() and target.is_dir():

            # link and target could be anything -> handle in consolidate fn
            consolidate(link, target, dry_run)
            # after consolidate fn, link should not exist
            if not dry_run:
                assert not link.exists(
                    follow_symlinks=False
                ), f"{link} exists after consolidate"

            symlink(link, target, dry_run)
            continue  # next target

        # Target is not in ignore or link lists
        if target.is_file():
            log.warning(f"{target} is not in ignore or link lists!")
            continue  # next target

        # Target is a directory
        print("Syncing subdirectory", target)
        sync(target, link, dry_run)


if __name__ == "__main__":
    # logging.basicConfig(level="INFO")
    dry_run = "-d" in sys.argv[1:]
    # dry_run = True
    if dry_run:
        print("*** DRY RUN ***")
    print("IGNORE = ", IGNORE)
    print("LINKS = ", LINKS)
    print()

    sync(DATA, Path.home(), dry_run)
