{ config, lib, ... }:
let 
  username = config.modules.other.system.username;
in {
networking = {
    networkmanager = {
        enable = true;
        dns = "systemd-resolved";
    };
  };
  services.resolved = {
      enable = true;
      fallbackDns = ["9.9.9.9"];
  };
  users.users.${username}.extraGroups = [ "networkmanager" ];
}
