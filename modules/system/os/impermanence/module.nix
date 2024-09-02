{
  inputs,
  config,
  lib,
  ...
}: let
  inherit (lib) optionalString mkIf mkForce;

  cfg = config.modules.system.impermanence;
in {
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];
  environment.persistence."/persist" = {
    directories = [
      "/etc/nixos"
      "/etc/nix"
      "/etc/NetworkManager/system-connections"
      "/var/db/sudo"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/pipewire"
      "/var/lib/systemd/coredump"
    ];

    files = [
      "/etc/machine-id"
    ];
  };
}
