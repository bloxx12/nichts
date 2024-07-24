{
  config,
  lib,
  ...
}: let
  inherit (config.modules.other.system) username;
  inherit (lib) mkForce;
in {
  networking = {
    enableIPv6 = true;
    networkmanager = {
      enable = true;
      plugins = mkForce []; # Bloated as hell, plugins be gone
      dns = "systemd-resolved";
    };
  };
  services.resolved = {
    enable = true;
    fallbackDns = ["9.9.9.9" "2620::fe::fe"];
  };
  users.users.${username}.extraGroups = ["networkmanager"];
}
