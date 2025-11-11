{ user
, homeStateVersion
, homeManagerPackages
, gitConfig
, ghosttyConfigRepo
, nvimConfigRepo
, ...
}:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.${user} = {
    home.stateVersion = homeStateVersion;
    programs.zsh.enable = true;

    programs.git = {
      enable = true;
      settings = {
        user.name = gitConfig.name;
        user.email = gitConfig.email;
      };
    };

    home.packages = homeManagerPackages;

    xdg.configFile."btop/btop.conf".source = ../../config/btop/btop.conf;
    xdg.configFile."nvim".source = nvimConfigRepo;
    xdg.configFile."ghostty/config".source = "${ghosttyConfigRepo}/config";
  };
}
