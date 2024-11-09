from dotfiles import *

shell(
    """
    yay --version || rm -rf /tmp/yay 
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    """,
    description="Install yay",
    stdin=True,
    stdout=True,
    stderr=True,
)
