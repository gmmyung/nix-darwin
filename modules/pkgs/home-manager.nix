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

  # Miscellaneous utilities
  tree-sitter
  lazygit

  # Fonts
  d2coding
  fontforge
]
