{
  description = "nix-darwin + Home Manager setup for gmmyung";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs @ { self, nixpkgs, nix-darwin, home-manager, ... }:
    let
      system = "aarch64-darwin";
      user = "gmmyung";
      homeDir = "/Users/${user}";
      stateVersion = 6;
      homeStateVersion = "24.11";

      experimentalFeatures = [
        "nix-command"
        "flakes"
      ];

      dockSettings = {
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.2;
        tilesize = 36;
        magnification = true;
        largesize = 64;
        show-recents = false;
        static-only = true;
        orientation = "bottom";
        minimize-to-application = true;
      };

      homebrewConfig = {
        enable = true;
        onActivation.cleanup = "uninstall";
        taps = [];
        brews = [ "mas" ];
        casks = [
          "ghostty"
          "chatgpt"
          "stats"
          "raspberry-pi-imager"
          "bambu-studio"
          "kicad"
          "freecad"
        ];
        masApps = {
          "KakaoTalk" = 869223134;
          "Parallels Desktop" = 1085114709;
          "Pets Therapy" = 1575542220;
	  "Microsoft PowerPoint" = 462062816;
	  "Microsoft Excel" = 462058435;
	  "Microsoft Word" = 462054704;
        };
      };

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      coreSystemPackages = import ./modules/pkgs/system.nix { inherit pkgs; };
      homeManagerPackages = import ./modules/pkgs/home-manager.nix { inherit pkgs; };
      gitConfig = {
        name = "gmmyung";
        email = "gmmyung@kaist.ac.kr";
      };
    in
    {
      darwinConfigurations.${user} = nix-darwin.lib.darwinSystem {
        inherit system pkgs;
        modules = [
          ./modules/darwin/base.nix
          home-manager.darwinModules.home-manager
          ./modules/home-manager/default.nix
        ];
        specialArgs = {
          inherit self user homeDir stateVersion homeStateVersion experimentalFeatures dockSettings homebrewConfig coreSystemPackages homeManagerPackages gitConfig;
        };
      };
    };
}
