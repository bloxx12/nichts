{ config, lib, ... }:
let 
  username = config.myOptions.other.system.username;
in {
networking = {
    networkmanager = {
        enable = true;
        dns = "systemd-resolved";
    };
  };
  services.resolved = {
      enable = true;
      fallbackDns = [
      "9.9.9.9"
      "2620::fe::fe"
      ];
  };
  users.users.${username}.extraGroups = [ "networkmanager" ];
}
