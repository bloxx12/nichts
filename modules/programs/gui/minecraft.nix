{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  inherit (config.modules.other.system) username;
  cfg = config.modules.programs.minecraft;
in {
  options.modules.programs.minecraft = {
    enable = mkEnableOption "minecraft";
    wayland = mkEnableOption "wayland";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      # Install minecraft
      home.packages = with pkgs; [prismlauncher];
    };
  };
}
