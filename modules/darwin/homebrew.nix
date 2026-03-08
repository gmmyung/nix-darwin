{
  enable = true;
  onActivation = {
    autoUpdate = true;
    upgrade = true;
    cleanup = "uninstall";
  };
  taps = [ 
    "laishulu/homebrew" 
    "jannis-baum/tap"
  ];
  brews = [ 
    "mas"
    "macism"
    "vivify"
    "platformio"
    "steipete/tap/remindctl"
  ];
  casks = [
    # Daily Apps
    "ghostty"
    "chatgpt"
    "discord"
    "zoom"
    "notion"
    "google-chrome"
    "codex"
    "macwhisper"
    "openclaw"
    "telegram"
    "obsidian"

    # Hardware + maker tooling
    "raspberry-pi-imager"
    "bambu-studio"
    "autodesk-fusion"
    "kicad"
    "freecad"
    "inkscape"
    "arduino-ide"
    "balenaetcher"
    "rustdesk"
    "qgroundcontrol"
    "blender"
    "creality-print"

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
