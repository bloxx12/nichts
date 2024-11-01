{config, ...}: let
  machine-id = builtins.substring 0 23 (builtins.hashString "sha256" config.networking.hostName);
in {
  system = {
    # faster rebuilds
    switch = {
      enable = false;
      enableNg = true;
    };
    # our state version
    stateVersion = "23.11";
  };
  environment.etc."machine-id".text = "${machine-id}\n";
}
