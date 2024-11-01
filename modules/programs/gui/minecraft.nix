{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.programs.minecraft;
in {
  options.modules.programs.minecraft = {
    enable = mkEnableOption "minecraft";
    wayland = mkEnableOption "wayland";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.prismlauncher];
  };
}
