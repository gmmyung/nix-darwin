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
    "fastfetch"
    "mas"
    "macism"
    "vivify"
    "platformio"
    "steipete/tap/remindctl"
    "easyeda2kicad"
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
    "cmux"
    "equinox"
    "minecraft"
    "corretto@11"

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
    "DaisyDisk" = 411643860;
  };
}
