# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Kevin's personal Arch Linux dotfiles, managed by **chezmoi**, plus a set of
bare-metal Arch install scripts. There is no build/test system; "applying" the
repo means running `chezmoi apply` on a target machine and letting its
`run_once_` scripts install packages.

`.chezmoiroot` is `home`, so **the chezmoi source directory is `home/`, not the
repo root**. Paths like `dot_config/...` in docs and commits are under `home/`.
Everything outside `home/` (`scripts/`, `modules/`, `hosts/`, `arch/`,
`claude-install.sh`, `install.sh`) is install tooling that chezmoi never sees.

Per-machine / per-iteration configuration lives on **git branches**, not in
data files: `dms` (current, niri + Dank Material Shell), `muse`, `dots`,
`angel`. `chezmoi init --branch <name>` selects one. When editing, assume the
checked-out branch is the intended target.

## Common commands

```sh
chezmoi diff                       # preview what apply would change
chezmoi apply                      # apply everything
chezmoi apply --include=scripts    # re-run the run_once_ scripts only
chezmoi apply ~/.config/niri       # apply a single path
chezmoi execute-template < file    # render a template with this machine's data
chezmoi cd                         # cd into the source dir (repo/home)
chezmoi init --branch dms --apply kjmcnamara1   # full bootstrap from GitHub

taplo fmt                          # format TOML (config in .taplo.toml)
bash -n <script>                   # syntax-check an install script before running
```

There is no lint or test target. `home/dot_config/rofi/scripts/.test_*.py`
files exist but are not wired to a runner.

## chezmoi source conventions

Attribute prefixes in filenames drive chezmoi's behavior — the important ones here:

- `dot_` → `.` ; `private_` → mode 600 ; `executable_` → +x
- `symlink_` → target is a symlink whose contents are the link destination
  (used to point `~/.config/X` at another in-repo file, often `.tmpl`)
- `create_` → written only if absent, never overwritten on re-apply
- `run_once_after_NN-*` / `run_once_before_NN-*` → shell scripts run in numeric
  order after/before the file tree is applied; re-run only when their contents change
- `.tmpl` → Go-template rendered with chezmoi data
- `encrypted_*.age` → age-encrypted; decrypted on apply

Leading-dot files chezmoi ignores by convention (`.settings.json`,
`.chezmoiignore`) are staging copies that a `symlink_*.tmpl` selects between.

### Secrets / age

Encryption is age. The identity is `~/.config/chezmoi/key.txt`; the recipient is
pinned in `home/.chezmoi.toml.tmpl`. `run_once_before_00-decrypt-private-key`
derives `key.txt` by decrypting `home/key.txt.age` with a passphrase, so a fresh
machine can unlock the rest (`home/encrypted_private_*.age`, SSH keys, gh hosts,
cargo credentials). `home/key.txt.age` itself is in `.chezmoiignore` (never
written to `$HOME`).

### Data and package installation

`home/.chezmoidata/*` (`packages.yml`, `machines.yml`, `services.toml`) is
template data. In practice the `run_once_after_*` scripts under
`home/.chezmoiscripts/` **hardcode their own package arrays** and call
`yay -S --needed --noconfirm`, grouped by concern (package-manager → caps2esc →
pipewire → printing → dank-material-shell → shell → neovim → yazi → guis). The
data files are partly aspirational; don't assume a package listed there is
actually installed by anything.

Scripts reach shared helpers via `${CHEZMOI_SOURCE_DIR}/../scripts/` — i.e. the
repo-root `scripts/` dir, one level up from the `home/` source root.
`scripts/gum-helper.sh` provides `info` / `warn` / `section` / `require` and
auto-installs `gum`.

`home/.chezmoiexternal.toml` pulls the Neovim config from
`github.com/kjmcnamara1/nvim` as a separate git repo into `~/.config/nvim`.

## OS install tooling (repo root)

Several **coexisting, partly-overlapping** approaches to installing Arch from the
live ISO. They are not unified — know which one you're touching:

- **`claude-install.sh`** — the actively-developed self-contained installer
  (most recent commits). Interactive `gum` prompts → GPT (1 GiB ESP + btrfs) →
  subvolumes `@ @home @snapshots @var_log @games` → `pacstrap` → a heredoc
  `chroot-setup.sh` run in `arch-chroot`. Boots a **mkinitcpio-built UKI**
  (`/boot/EFI/Linux/*.efi`) via **systemd-boot** (auto-discovery, no loader
  entries). Snapper + snap-pac for timeline snapshots, with **no** bootloader
  snapshot integration. Sources `scripts/gum-helper.sh`. Ends by running
  `chezmoi init --branch dms --apply` as the new user.
- **`install.sh`** — older self-contained installer referenced by `README.md`.
  Similar shape but subvolumes `@ @home @var @snapshots @games`, systemd-boot
  with an explicit `loader/entries/arch.conf` (non-UKI: `vmlinuz-linux` +
  `amd-ucode.img` + `initramfs`). Being superseded by `claude-install.sh`.
- **`scripts/*.sh`** — a modular library (`manipulate-disk.sh`,
  `configure-boot.sh`, `configure-network.sh`, …). Each is `source`d with an
  `archmount` variable pointing at the mounted target and operates via
  `arch-chroot "$archmount"`. Subvolume names differ again (`@ @home @log @pkg
  @games`). `configure-package-manager.sh` (chaotic-aur + yay + pacman.conf
  tweaks) is the one piece also invoked from chezmoi, by
  `run_once_after_01-install-package-manager`.
- **`modules/*.toml` + `hosts/*.toml`** — a declarative installer spec (a host
  selects modules; modules declare `packages`, `modules` deps, `hooks`). No
  resolver is checked in and several referenced modules/hooks (`niri`, `locale`,
  `hooks/angel-pre.sh`) don't exist yet — this is a WIP design, not runnable.
- **`arch/`** — `archinstall` JSON profiles (`angel.json`, `muse.json`,
  `users.json`) and `arch/install`, a wrapper that runs `archinstall --config`
  then chezmoi. The JSON encodes the same intent: systemd-boot, `uki: true`,
  plymouth `bgrt`, btrfs + Snapper.

Common invariants across all of them: UEFI-only, btrfs root on subvolume `@`,
`compress=zstd`, 1 GiB FAT32 ESP mounted at `/boot`, plymouth `bgrt` theme,
kernel cmdline `quiet splash`, an NFS `/mnt/NAS` fstab entry
(`192.168.0.10:/mnt/md1`), NetworkManager with the **iwd** wifi backend, and
`amd-ucode` (Intel detected as a fallback in `claude-install.sh`).

## Desktop stack (what the dotfiles configure)

- **niri** (scrolling Wayland compositor) is the current WM —
  `home/dot_config/niri/`, `config.kdl.tmpl` with `include`d `apps/*.kdl` and
  `dms/*.kdl`.
- **Dank Material Shell (DMS)** on **quickshell** is the bar/shell/greeter —
  `home/dot_config/DankMaterialShell/`. Login is **greetd** + `dms-greeter`.
- Hyprland configs (`home/dot_config/hypr/`) are the previous setup, kept for the
  `muse` branch; many files there are `.bak`.
- Theming pipeline: **wallust** and **matugen** render color templates
  (`home/dot_config/wallust/templates/`, `home/dot_config/matugen/templates/`)
  from the current wallpaper into per-app color files. `create_*` config files
  are generated once. Named schemes: `nord`, `ansinord`.
- Shells: fish is primary (`home/dot_config/fish/`), with nushell, zsh, xonsh
  configs also present; starship prompt across all of them.

## Gotchas

- Edits to files under `home/` do nothing until `chezmoi apply` runs on a
  machine; there is no daemon.
- A `run_once_` script only re-runs when its **content hash** changes. To force
  a re-run, change the file or clear its entry from chezmoi's state.
- `README.md` still points at `./install.sh`; the current installer is
  `claude-install.sh`.
- The `.opt.packageManager` template branch (Windows/scoop) has no data backing
  it — the Linux path is the only maintained one.
- TOML is expected to be `taplo fmt`-clean (aligned entries, indented tables).
