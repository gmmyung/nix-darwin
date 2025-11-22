{ pkgs }:
with pkgs; [
  # Daily driver CLI + editors
  neovim
  nodejs
  gh
  ripgrep
  btop

  # Build tools
  cmake
  ninja
  llvm

  # Language servers
  cmake-language-server
  lua-language-server
  typescript-language-server
  pyright

  # Embedded utilities
  gcc-arm-embedded
  probe-rs-tools
  pulseview
  arduino-cli

  # AI helpers
  codex

  # Miscellaneous utilities
  tree-sitter
  lazygit
  presenterm
  mermaid-cli

  # Fonts
  d2coding
  fontforge
]
