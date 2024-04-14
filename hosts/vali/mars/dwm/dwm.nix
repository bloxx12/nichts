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
    };
    nixpkgs.overlays = [
    (final: prev: {
      dwm = prev.dwm.overrideAttrs (old: {src = ./dwm-6.5;});
      dmenu = prev.dmenu.overrideAttrs (old: {src = ./dmenu-5.3;});
    })
    ];
    environment.systemPackages = with pkgs; [
      (st.overrideAttrs (oldAttrs: rec { src = ./st-0.9.2; }))
    ];

  };
}
