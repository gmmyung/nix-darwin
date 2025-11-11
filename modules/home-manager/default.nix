{ user
, homeStateVersion
, homeManagerPackages
, gitConfig
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
    };

    programs.git = {
      enable = true;
      settings = {
        user.name = gitConfig.name;
        user.email = gitConfig.email;
      };
    };

    home.packages = homeManagerPackages;

    xdg.configFile."btop/btop.conf".source = ../../config/btop/btop.conf;
    xdg.configFile."nvim".source = ../../config/nvim;
    xdg.configFile."ghostty/config".source = ../../config/ghostty/config;
  };
}
