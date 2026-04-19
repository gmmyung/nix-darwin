{ pkgs }:
with pkgs; [
  # Daily driver CLI + editors
  neovim
  nodejs
  openjdk_headless
  gh
  ripgrep
  btop

  # Language servers
  cmake-language-server
  lua-language-server
  typescript-language-server
  pyright
  rust-analyzer

  # Miscellaneous utilitier
  tree-sitter
  lazygit

  # Fonts
  d2coding
  fontforge
]
