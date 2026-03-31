{ user
, homeDir
, homeStateVersion
, homeManagerPackages
, gitConfig
, pkgs
, lib
, ...
}:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.${user} = {
    home.stateVersion = homeStateVersion;
    programs.zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [ "git" ];
      };
      initContent = ''
        # Ensure Homebrew CLI tools are available in every shell
        if [ -x /opt/homebrew/bin/brew ]; then
          eval "$(/opt/homebrew/bin/brew shellenv)"
        fi

        autoload -Uz add-zsh-hook
        # Cache repo probes so repeated cd operations do not keep re-evaluating the same flake.
        typeset -gA _auto_devshell_cache
        typeset -g _auto_devshell_system=""

        _auto_devshell_repo_root() {
          git rev-parse --show-toplevel 2>/dev/null
        }

        _auto_devshell_has_default_shell() {
          local repo_root="$1"

          if [[ -n "''${_auto_devshell_cache[$repo_root]-}" ]]; then
            [[ "''${_auto_devshell_cache[$repo_root]}" == "1" ]]
            return
          fi

          if [[ -z "''${_auto_devshell_system}" ]]; then
            _auto_devshell_system="$(nix eval --impure --raw --expr builtins.currentSystem 2>/dev/null)"
          fi

          if [[ -z "''${_auto_devshell_system}" ]]; then
            _auto_devshell_cache[$repo_root]="0"
            return 1
          fi

          # Only auto-enter repos that expose a default dev shell for this machine.
          if nix eval --raw "$repo_root#devShells.''${_auto_devshell_system}.default.drvPath" >/dev/null 2>&1; then
            _auto_devshell_cache[$repo_root]="1"
            return 0
          fi

          _auto_devshell_cache[$repo_root]="0"
          return 1
        }

        _auto_devshell_enter() {
          local repo_root

          command -v git >/dev/null 2>&1 || return
          command -v nix >/dev/null 2>&1 || return

          repo_root="$(_auto_devshell_repo_root)" || return
          [[ -n "$repo_root" ]] || return
          [[ -f "$repo_root/flake.nix" ]] || return
          [[ "''${AUTO_DEVSHELL_ROOT:-}" == "$repo_root" ]] && return

          _auto_devshell_has_default_shell "$repo_root" || return

          # Start a nested shell once per repo; exiting it returns to the parent shell.
          AUTO_DEVSHELL_ROOT="$repo_root" nix develop "$repo_root" --command zsh -i
        }

        add-zsh-hook chpwd _auto_devshell_enter
        _auto_devshell_enter
      '';
    };

    programs.git = {
      enable = true;
      settings = {
        user.name = gitConfig.name;
        user.email = gitConfig.email;
      };
    };

    home.shellAliases = {
      lg = "lazygit";
    };

    home.packages = homeManagerPackages;

    xdg.configFile."btop/btop.conf".source = ../../config/btop/btop.conf;
    xdg.configFile."nvim".source = ../../config/nvim;
    xdg.configFile."ghostty/config".source = ../../config/ghostty/config;

  };
}
