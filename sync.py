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
    log.info("Moving %s to %s", src, dst)
    if dry_run:
        return
    src.rename(dst)


def symlink(link: Path, target: Path, dry_run: bool):
    print(link, " -> ", target)
    if dry_run:
        return


def prompt(msg: str, opts: list, default: int = 0):
    pass


def consolidate(source: Path, destination: Path, dry_run: bool):
    pass


def sync(link_dir: Path, target_dir: Path, dry_run: bool):
    pass


if __name__ == "__main__":
    logging.basicConfig(level="DEBUG")
    dry_run = "-d" in sys.argv[1:]
    dry_run = True
    if dry_run:
        print("DRY RUN")
    sync(DATA, Path.home(), dry_run)
