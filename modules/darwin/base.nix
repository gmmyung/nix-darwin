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
}
