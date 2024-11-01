{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.system.hardware.bluetooth;
  inherit (lib) mkIf;
in {
  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = mkIf cfg.powerOnBoot true;
    };
    environment.systemPackages = with pkgs; [
      bluetuith
      bluez
      blueman
    ];
  };
}
