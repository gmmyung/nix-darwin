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
  
  # Web tools
  hugo

  # Language servers
  cmake-language-server
  lua-language-server
  typescript-language-server
  pyright
  rust-analyzer

  # Embedded utilities
  gcc-arm-embedded
  probe-rs-tools
  arduino-cli
  tio

  # Miscellaneous utilities
  tree-sitter
  lazygit
  presenterm
  mermaid-cli
  pandoc
  tectonic
  marp-cli
  pixi

  # Fonts
  d2coding
  fontforge
]
