{ pkgs, lib, config, callPackage, ... }:
with lib; let
  username = config.modules.other.system.username;
  cfg = config.modules.programs.dwm;
in {
  options.modules.programs.dwm.enable = mkEnableOption "dwm";

  config = mkIf cfg.enable {
        services.xserver = {
      enable = true;
      xkb.layout =  "de";
      windowManager.dwm = {
          enable = true;
      };
      displayManager.sddm = {
          enable = true;
          setupScript = "xrandr --output HDMI-1 --rotate normal --output DP-2 --rotate normal --left-of HDMI-1 --output HDMI-0 --right-of HDMI-1";
#          defaultSession = "dwm";
      };
    };
    nixpkgs.overlays = [
    (final: prev: {
      dwm = prev.dwm.overrideAttrs (old: {src = ./dwm-6.5;});
    })
    ];
    environment.systemPackages = with pkgs; [
      (st.overrideAttrs (oldAttrs: rec { src = ./st-0.9.2; }))
      (dmenu.overrideAttrs (oldAttrs: rec { src = ./dmenu-5.3; }))
    ];

  };
}
