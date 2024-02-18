#!/usr/bin/env python3
from pathlib import Path

IGNORE = [
    ".git",
    ".vscode",
    "LICENSE",
    "README.md",
    "setup_arch.sh",
    "setup_win.ps1",
    "create_links.py",
]

DOTFILE_DIR = Path(__file__).resolve().parent


def create_links(target_dir: Path, link_dir: Path):
    for target in target_dir.iterdir():
        if target.name in IGNORE:
            continue

        rel_path = target.relative_to(target_dir)
        link = link_dir / rel_path

        if link.is_symlink():  # and link.is_dir():
            link.unlink()
            print("Removed symlink", link)

        if target.is_dir():
            if not link.is_dir():
                link.mkdir()
                print("Created directory", link)
            create_links(target, link)
        else:
            link.symlink_to(target)
            print("Created symlink", link, "->", target)


if __name__ == "__main__":
    create_links(DOTFILE_DIR, Path.home())
