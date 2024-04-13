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
   #       package = pkgs.dwm.overrideAttrs { src = ./dwm-6.5/dwm; };
      };
    };
    nixpkgs.overlays = [
    (final: prev: {
      dwm = prev.dwm.overrideAttrs (old: {src = ./dwm-6.5;}); #FIX ME: Update with path to your dwm folder
    })
    ];
  };
}
