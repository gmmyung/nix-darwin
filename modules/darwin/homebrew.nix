{
  enable = true;
  onActivation.cleanup = "uninstall";
  taps = [ "laishulu/homebrew" ];
  brews = [ 
    "mas"
    "macism"
  ];
  casks = [
    # Daily Apps
    "ghostty"
    "chatgpt"
    "discord"
    "zoom"

    # Hardware + maker tooling
    "raspberry-pi-imager"
    "bambu-studio"
    "autodesk-fusion"
    "kicad"
    "freecad"
    "inkscape"
    "arduino-ide"

    # macOS polish
    "stats"
    "jordanbaird-ice"
    "logi-options+"
    "betterdisplay"
  ];
  masApps = {
    # Comms + productivity suite
    "KakaoTalk" = 869223134;
    "Microsoft Word" = 462054704;
    "Microsoft Excel" = 462058435;
    "Microsoft PowerPoint" = 462062816;

    # Virtualization + wellness
    "Parallels Desktop" = 1085114709;
    "Tailscale" = 1475387142;
    "Pets Therapy" = 1575542220;
    "Amphetamine" = 937984704;
  };
}
