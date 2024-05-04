{ config, pkgs, lib, ... }: 

with lib;
let 
  username = config.modules.other.system.username;
  cfg = config.modules.programs.hyprland;
in {
  options.modules.programs.hyprland.enable = mkEnableOption "hyprland";
  config = mkIf cfg.enable {
     programs.hyprland = {
        enable = true;
        xwayland.enable = true;
     };
     environment.sessionVariables = {
        WLR_NO_HARDWARE_CURSORS = "1";
        NIXOS_OZONE_WL = "1";
     };
     hardware = {
        opengl.enable = true;
        nvidia.modesetting.enable = true;
     };
     environment.systemPackages = with pkgs; [
          (waybar.overrideAttrs (oldAttrs: {
              mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
            }))
          dunst
          libnotify
          hyprpaper
     ];
  };
}

