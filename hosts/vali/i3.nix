{ pkgs, lib, config, callPackage, ... }:
with lib; let
  cfg = config.myOptions.programs.i3;
in {
  options.myOptions.programs.i3.enable = mkEnableOption "i3";

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      desktopManager = {
        xterm.enable = false;
        xfce = {
          enable = true;
          noDesktop = true;
          enableXfwm = false;
        };
      };
      displayManager.defaultSession="xfce+i3";
        windowManager.i3 = {
          enable = true;
        extraPackages = with pkgs; [
          dmenu
          i3status
          i3lock
        ];
      };
    };
  };
}
