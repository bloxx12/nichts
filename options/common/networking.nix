{ config, lib, ... }:

{
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
  user.users.config.myOptions.other.system.username.extraGroups = [ "networkmanager" ];
}
