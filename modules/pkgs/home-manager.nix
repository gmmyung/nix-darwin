{ pkgs }:
with pkgs; [
  # Daily driver CLI + editors
  neovim
  nodejs
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
  typst

  # Fonts
  d2coding
  fontforge
]
