{ self
, user
, homeDir
, stateVersion
, experimentalFeatures
, dockSettings
, homebrewConfig
, coreSystemPackages
, ...
}:

{
  nix.settings.experimental-features = experimentalFeatures;
  environment.systemPackages = coreSystemPackages;

  users.users.${user}.home = homeDir;
  system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = stateVersion;
  system.primaryUser = user;

  system.defaults.dock = dockSettings;
  homebrew = homebrewConfig;
}
