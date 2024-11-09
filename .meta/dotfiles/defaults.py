from typing import Any, NoReturn


class Defaults:
    shell: dict[str, Any] = {
        "cwd": None,
        "quiet": False,
        "stdin": False,
        "stdout": False,
        "stderr": False,
    }
    link: dict[str, Any] = {
        "create": False,
        "relink": False,
        "force": False,
        "relative": False,
        "canonicalize": True,
        "ignore-missing": False,
        "glob": False,
        "exclude": [],
        "prefix": "",
    }
    create: dict[str, Any] = {"mode": 0o777}
    clean: dict[str, Any] = {
        "force": False,
        "recursive": False,
    }

    @classmethod
    def reset(cls):
        cls.shell = {
            "cwd": None,
            "quiet": False,
            "stdin": False,
            "stdout": False,
            "stderr": False,
        }
        cls.link = {
            "create": False,
            "relink": False,
            "force": False,
            "relative": False,
            "canonicalize": True,
            "ignore-missing": False,
            "glob": False,
            "exclude": [],
            "prefix": "",
        }
        cls.create = {"mode": 0o777}
        cls.clean = {"force": False, "recursive": False}

    def __new__(cls) -> NoReturn:
        raise TypeError("Defaults is a Singleton class")
