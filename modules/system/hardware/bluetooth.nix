{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.system.hardware.bluetooth;
  inherit (config.modules.other.system) username;
  inherit (lib) mkIf;
in {
  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = mkIf cfg.powerOnBoot true;
    };

    home-manager.users.${username}.home.Packages = with pkgs; [
      bluetuith
    ];
  };
}
