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
    programs.zsh.enable = true;

    programs.git = {
      enable = true;
      settings = {
        user.name = gitConfig.name;
        user.email = gitConfig.email;
      };
    };

    home.packages = homeManagerPackages;
  };
}
