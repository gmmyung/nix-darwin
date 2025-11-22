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
