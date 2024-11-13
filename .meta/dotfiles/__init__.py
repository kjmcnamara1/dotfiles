import logging

from .defaults import Defaults
from .paths import clean, create, delete, link
from .shell import shell

logging.basicConfig(level="DEBUG")

__all__ = ["Defaults", "clean", "create", "delete", "link", "shell"]
