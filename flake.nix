{
  description = "nix-darwin + Home Manager setup for gmmyung";

  inputs = {
    # Base package sets
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # nix-darwin
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, nix-darwin, home-manager, ... }:
  let
    system = "aarch64-darwin";
    user = "gmmyung";

    # ---------------------------------------------------------
    # pkgs with full unfree support enabled
    # ---------------------------------------------------------
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
  in
  {
    # ---------------------------------------------------------
    # macOS system configuration (nix-darwin)
    # ---------------------------------------------------------
    darwinConfigurations.${user} = nix-darwin.lib.darwinSystem {
      inherit system pkgs;

      modules = [
        # ------------------------------
        # Base system configuration
        # ------------------------------
        {
          nix.settings.experimental-features = [
            "nix-command"
            "flakes"
          ];

          # Use the overridden pkgs
          environment.systemPackages = with pkgs; [
            curl
            wget
            git
            neovim
          ];

          users.users.${user}.home = "/Users/${user}";
          system.configurationRevision = self.rev or self.dirtyRev or null;
          system.stateVersion = 6;
          system.primaryUser = user;

          # macOS Dock settings
          system.defaults.dock = {
            autohide = true;
            autohide-delay = 0.0;
            autohide-time-modifier = 0.2;
            tilesize = 36;
            magnification = true;
            largesize = 64;
            show-recents = false;
            orientation = "bottom";
            minimize-to-application = true;
          };

          # Homebrew configuration
          homebrew = {
            enable = true;
            onActivation.cleanup = "uninstall";
            taps = [];
            brews = [
	      "mas"
	    ];
            casks = [
              "ghostty"
              "chatgpt"
	      "codex"
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
	    };
          };
        }

        # ---------------------------------------------------------
        # Home Manager integration for nix-darwin
        # ---------------------------------------------------------
        home-manager.darwinModules.home-manager

        # ---------------------------------------------------------
        # Home Manager user configuration
        # ---------------------------------------------------------
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.${user} = {
            home.stateVersion = "24.11";

            # Shell
            programs.zsh.enable = true;

            # Git config
            programs.git = {
              enable = true;
              settings = {
                user.name = "gmmyung";
                user.email = "gmmyung@kaist.ac.kr";
              };
            };

            # User packages (using pkgs with full unfree enabled)
            home.packages = with pkgs; [
              btop
              ripgrep
              gh
              lazygit
	      probe-rs-tools
	      cmake
	      cmake-language-server
	      ninja
	      gcc-arm-embedded
            ];
          };
        }
      ];
    };
  };
}

