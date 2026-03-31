{ self
, user
, homeDir
, stateVersion
, experimentalFeatures
, dockSettings
, homebrewConfig
, coreSystemPackages
, pkgs
, ...
}:

let
  flakeDir = "/etc/nix-darwin";
  autoUpgradeStdoutLog = "/var/log/nix-darwin-auto-upgrade.log";
  autoUpgradeStderrLog = "/var/log/nix-darwin-auto-upgrade.error.log";
in
{
  nix.settings.experimental-features = experimentalFeatures;
  environment.systemPackages = coreSystemPackages;

  users.users.${user} = {
    home = homeDir;
    shell = pkgs.zsh;
  };
  system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = stateVersion;
  system.primaryUser = user;

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;

  security.pam.services.sudo_local.touchIdAuth = true;

  system.defaults.dock = dockSettings;
  homebrew = homebrewConfig;

  launchd.daemons.nix-darwin-auto-upgrade = {
    environment = {
      HOME = "/var/root";
      LOGNAME = "root";
      USER = "root";
    };
    path = [ pkgs.git ];
    script = ''
      set -euo pipefail

      if /usr/bin/pmset -g batt | /usr/bin/grep -q "Battery Power"; then
        echo "Skipping nix-darwin auto-upgrade because the system is on battery power."
        exit 0
      fi

      cd ${flakeDir}
      /run/current-system/sw/bin/nix \
        --extra-experimental-features 'nix-command flakes' \
        flake update --flake ${flakeDir}
      /run/current-system/sw/bin/darwin-rebuild switch --flake ${flakeDir}#${user}
    '';
    serviceConfig = {
      RunAtLoad = false;
      StartCalendarInterval = {
        Hour = 4;
        Minute = 0;
      };
      WorkingDirectory = flakeDir;
      StandardOutPath = autoUpgradeStdoutLog;
      StandardErrorPath = autoUpgradeStderrLog;
    };
  };
}
