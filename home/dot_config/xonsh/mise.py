from pathlib import Path
from xonsh.built_ins import XSH
import subprocess

ctx = XSH.ctx
mise_init = subprocess.run(
    [Path("~/bin/mise").expanduser(), "activate", "xonsh"],
    capture_output=True,
    encoding="UTF-8",
).stdout
XSH.builtins.execx(mise_init, "exec", ctx, filename="mise")
