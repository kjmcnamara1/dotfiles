import json
import subprocess
from pathlib import Path

import dotbot
from dotbot.cli import read_config
from dotbot.util import module


class Included(dotbot.Plugin):
    _directive = "included"

    def can_handle(self, directive):
        return self._directive == directive

    def handle(self, directive, data):
        success = True
        if directive != self._directive:
            raise ValueError(f"Include cannot handle directive {directive}")

        app = self._find_dotbot()
        base_directory = self._context.base_directory()
        # self._log.debug(f"{data = }")
        plugin_args = self._collect_plugins()
        # self._log.debug(f"{plugin_args = }")

        for config_file in data:
            config = read_config(config_file)
            # self._log.debug(f"{config = }")
            try:
                self._write_config_file(
                    [{"defaults": self._context.defaults()}] + config
                )

                cmd = [
                    app,
                    "--base-directory",
                    base_directory,
                    "--config-file",
                    self._config_file,
                ] + plugin_args
                # self._log.debug(f"include: cmd to pass: {cmd}")

                self._log.debug(f"include: begin {config_file}")
                ret = subprocess.run(cmd, stdin=subprocess.PIPE)
                self._log.debug(f"include: end {config_file}")

                if ret.returncode != 0:
                    self._log.error(f"include: error: {ret}")
                    success = False
            except Exception as e:  # FIXME: Don't know what to catch here...
                self._log.error(f"include: error: {e}")
                success &= False
            finally:
                ...
                self._delete_config_file()

        return success

    def _find_dotbot(self) -> Path:
        app_path = Path(dotbot.__file__).parents[1] / "bin/dotbot"
        self._log.debug(f"include: dotbot app path: {app_path}")
        return app_path

    def _collect_plugins(self) -> list[str]:
        plugins = [
            plugin.__file__
            for plugin in module.loaded_modules
            # if plugin.__name__ != self._directive
        ]
        self._log.debug(f"include: collected plugins: {plugins}")
        return [val for tup in zip(["--plugin"] * len(plugins), plugins) for val in tup]

    @property
    def _config_file(self) -> Path:
        return Path(__file__).parent / f"{self._directive}.conf.json"

    def _delete_config_file(self):
        self._config_file.unlink(missing_ok=True)

    def _write_config_file(self, data):
        self._delete_config_file()
        self._config_file.write_text(json.dumps(data), encoding="utf-8")
