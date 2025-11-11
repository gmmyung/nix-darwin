# nix-darwin for gmmyung

Personal `nix-darwin` + Home Manager setup that bootstraps gmmyung's macOS workstation.

## Structure
- `flake.nix` wires the `nix-darwin` system with Home Manager.
- `modules/` contains the darwin and Home Manager modules plus curated package lists.
- `config/ghostty`, `config/nvim`, `config/btop` vendor the upstream app configs so they can be linked declaratively.

## Usage
```bash
# build & apply the configuration
sudo darwin-rebuild switch --flake .#gmmyung
```

## Managed apps
- Ghostty: `~/.config/ghostty/config` is sourced from `config/ghostty/config`.
- Neovim: Entire tree under `~/.config/nvim` comes from `config/nvim`.
- btop: `~/.config/btop/btop.conf` mirrors `config/btop/btop.conf`.
- Touch ID for sudo is enabled via `security.pam.services.sudo_local.touchIdAuth`.
