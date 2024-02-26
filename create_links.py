import os
import platform
import sys
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

RELOCATIONS = {
    r".config\nushell": Path(os.environ.get("APPDATA", "~/AppData/Roaming"))
    / "nushell",
    r".config\nvim": Path(os.environ.get("LOCALAPPDATA", "~/AppData/Local")) / "nvim",
}

DOTFILE_DIR = Path(__file__).resolve().parent


def create_links(target_dir: Path, link_dir: Path, dry_run: bool = False):
    for target in target_dir.iterdir():
        if target.name in IGNORE:
            continue

        rel_path = target.relative_to(target_dir)
        if platform.system() == "Windows":
            # print("target = ", target)
            # print("key = ", str(target.relative_to(DOTFILE_DIR)))
            link = RELOCATIONS.get(
                str(target.relative_to(DOTFILE_DIR)), link_dir / rel_path
            )
        else:
            link = link_dir / rel_path

        if link.is_symlink():  # and link.is_dir():
            if not dry_run:
                link.unlink()
            print("Removed symlink", link)

        if target.is_dir():
            if not link.is_dir():
                if not dry_run:
                    link.mkdir()
                print("Created directory", link)
            create_links(target, link, dry_run)
        else:
            try:
                if not dry_run:
                    link.symlink_to(target)
                print("Created symlink", link, "->", target)
            except FileExistsError:
                print("File already exists", link)


if __name__ == "__main__":
    # dry_run = True
    dry_run = "-d" in sys.argv[1:]
    if dry_run:
        print("DRY RUN")
    create_links(DOTFILE_DIR, Path.home(), dry_run)
