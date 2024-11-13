import logging
import os
import shutil
import sys
from pathlib import Path

from .defaults import Defaults

log = logging.getLogger("dotfiles")
type PathLike = str | Path


def _abs_path(path: PathLike) -> Path:
    """
    Converts a path to an absolute path.

    Expands the path to an absolute path by first expanding any user
    references (e.g. ~/) and environment variables (e.g. $HOME) and then
    resolving to an absolute path.

    Args:
        path: The path to convert.

    Returns:
        The absolute path.
    """
    return Path(os.path.expandvars(path)).expanduser().resolve()


def _exists(path: PathLike) -> bool:
    return _abs_path(path).exists()


def _is_link(path: PathLike) -> bool:
    return _abs_path(path).is_symlink()


def _relative_path(source: PathLike, target: PathLike) -> Path:
    return _abs_path(source).relative_to(_abs_path(target).parent)


def _has_glob_chars(source: PathLike) -> bool:
    return any(i in str(source) for i in "?*[")


def _glob(pattern: str):
    found = [p.resolve() for p in Path.cwd().glob(pattern)]
    # if using recursive glob (`**`), filter results to return only files:
    if "**" in pattern and not pattern.endswith(str(os.sep)):
        log.debug(f"Excluding directories from recursive glob: {pattern}")
        found = [p for p in found if p.is_file()]

    return found


def _create_glob_results(pattern: str, exclude_paths: list[str]) -> list[Path]:
    log.debug(f"Globbing with pattern: {pattern}")
    include = _glob(pattern)
    log.debug(f"Glob found : {include}")
    # filter out any paths matching the exclude globs:
    exclude = []
    for expat in exclude_paths:
        log.debug(f"Excluding globs with pattern: {expat}")
        exclude.extend(_glob(expat))
    log.debug(f"Excluded globs from '{pattern}': {exclude}")
    ret = set(include) - set(exclude)
    return list(ret)


def _default_link_destination(target: PathLike, source: PathLike) -> Path:
    if not source:
        basename: str = _abs_path(target).name
        source = basename[1:] if basename.startswith(".") else basename
    return Path(source)


def _link_destination(path: PathLike) -> Path:
    path = _abs_path(path)
    destination = path.readlink()
    # FIXME: Trim windows path with pathlib
    if sys.platform[:5] == "win32" and destination.startswith("\\\\?\\"):
        destination = destination[4:]
    return destination


def create(path: PathLike, **options) -> bool:
    options = Defaults.create | options
    abs_path = _abs_path(path)

    if not abs_path.exists():
        log.debug(f'Trying to create path "{abs_path}" with mode {options['mode']:o}')
        try:
            log.info(f'Creating path "{path}"')
            abs_path.mkdir(parents=True, mode=options["mode"])
        except OSError:
            log.warning(f'Failed to create path "{path}"')
            return False
    else:
        log.info(f'Path exists "{path}"')

    return True


def link(path_from: PathLike, path_to: PathLike = "", **options):
    options = Defaults.link | options
    log.debug(f"Trying to link {path_from} -> {path_to}")
    success = True

    if options["glob"] and _has_glob_chars(path_to):
        glob_results = _create_glob_results(str(path_to), options["exclude"])
        log.info(f"Globs from '{path_to}': {glob_results}")
        for abs_glob in glob_results:
            glob_dir = os.path.commonpath([_abs_path(path_to), abs_glob])
            glob_to = abs_glob.relative_to(glob_dir) if glob_dir else abs_glob
            if options["prefix"]:
                glob_to = Path(options["prefix"]) / glob_to
            glob_from = _abs_path(path_from) / glob_to
            success &= _link(glob_from, glob_to, **options)
    else:
        success = _link(path_from, path_to, **options)

    if success:
        log.info("All links have been set up")
    else:
        log.error("Some links were not successfully set up")

    return success


def _link(path_from: PathLike, path_to: PathLike = "", **options) -> bool:
    """Create symlink. No globs allowed."""
    path_to = _default_link_destination(path_from, path_to)
    abs_from = _abs_path(path_from)
    abs_to = _abs_path(path_to)

    link_destination = path_to.relative_to(path_from) if options["relative"] else abs_to

    if options["create"]:  # create parent directories
        create(abs_from.parent, **options)
    if options["force"] or options["relink"]:  # delete existing link/file
        delete(abs_from, **options)
    # success &= _link(abs_from, abs_to, **options)
    if options["ignore-missing"] or abs_to.exists():  # dest exists
        if abs_from.exists():
            if not abs_from.is_symlink():
                log.warning(
                    f"{path_from} already exists but is a regular file or directory"
                )
            elif abs_from.readlink() != link_destination:
                log.warning(
                    f"Incorrect link exists {path_from} -> {abs_from.readlink()}"
                )
            else:
                log.info(f"Link {path_from} -> {path_to} already exists")
        else:
            try:
                abs_from.symlink_to(abs_to, abs_to.is_dir())
            except OSError:
                log.warning(f"Failed to link {path_from} -> {path_to}")
            else:
                log.info(f"Created link {path_from} -> {path_to}")
                return True
    else:  # dest doesn't exist
        log.warning(f"Nonexistent link destination {path_from} -> {path_to}")

    return False


def delete(path: PathLike, **options) -> bool:
    options = Defaults.link | options
    abs_path = _abs_path(path)
    success = True
    log.debug(f"Trying to delete {abs_path}")
    try:
        if options["relink"] and abs_path.is_symlink():
            abs_path.unlink()
        elif options["force"]:
            if abs_path.is_dir() and not abs_path.is_symlink():
                shutil.rmtree(abs_path)
            else:
                abs_path.unlink()
        log.info(f"Removed {path}")
    except FileNotFoundError:
        log.warning(f"{path} does not exist")
    except OSError:
        log.warning(f"Failed to remove {path}")
        success = False

    return success


def clean(path: str, **options):
    options = Defaults.clean | options
    success = True


if __name__ == "__main__":
    logging.basicConfig(level="DEBUG")

    # Defaults.link["create"] = True
    # Defaults.link["relink"] = True
    # Defaults.link["relative"] = True
    # Defaults.link["force"] = True

    # print(link("~/.gitconfig"))
    # print(_delete("~/yyy"))
    # print(_relative_path("~", "~/Pictures"))
    # link("~/.config/", "kde/*", glob=True, exclude=["kde/README.md"], prefix="foo")
    # link("kde/", "kde/*")
