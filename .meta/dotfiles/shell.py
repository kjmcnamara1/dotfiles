import logging
import subprocess

from .defaults import Defaults

log = logging.getLogger("dotfiles")


def shell(command: str, description: str = "", **options) -> bool:
    options = Defaults.shell | options
    # log.debug(options)
    success = True
    if options["quiet"]:
        if description:
            log.info(description)
    elif not description:
        log.info(command)
    else:
        log.info(f"{description} [{command}]")

    ret = subprocess.run(
        command,
        shell=True,
        cwd=options["cwd"],
        stdin=None if options["stdin"] else subprocess.DEVNULL,
        stdout=None if options["stdout"] else subprocess.DEVNULL,
        stderr=None if options["stderr"] else subprocess.DEVNULL,
    )

    if ret.returncode != 0:
        success = False
        log.warning(f'Command "{command}" failed with exit code {ret.returncode}')

    if success:
        log.info("All commands have been executed")
    else:
        log.error("Some commands were not successfully executed")

    return success
