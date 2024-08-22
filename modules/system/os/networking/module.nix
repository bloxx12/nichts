{config, ...}: let
  inherit (config.modules.other.system) username;
in {
  imports = [
    ./networkmanager.nix
  ];
  networking = {
    hostname = username;
    enableIPv6 = true;
    nameservers = [
      # quad9 DNS
      "9.9.9.9"
      "2620::fe::fe"
    ];
  };
  services.resolved = {
    enable = true;
    # quad9 dns
    fallbackDns = ["9.9.9.9" "2620::fe::fe"];
  };
  users.users.${username}.extraGroups = ["networkmanager"];
}
