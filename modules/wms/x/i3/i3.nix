{
  pkgs,
  lib,
  config,
  ...
}: let
  username = config.modules.other.system.username;
  cfg = config.modules.wms.x.i3;
in {
  options.modules.wms.x.i3.enable = lib.mkEnableOption "i3";

  config = lib.mkIf cfg.enable {
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
      config.common.default = "*";
    };
    services = {
      xserver = {
        enable = true;
        xkb.layout = "de";
        desktopManager.xterm.enable = false;
        windowManager.i3.enable = true;
        displayManager = {
          lightdm.enable = true;
          defaultSession = "none+i3";
          setupCommands = "${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-1 --rotate normal --output DP-2 --rotate normal --left-of HDMI-1 --output HDMI-0 --right-of HDMI-1";
        };
      };
    };
    home-manager.users.${username} = {
      xsession.windowManager.i3 = {
        #  enable = false;
        #  package = pkgs.i3-gaps;
      };
    };
  };
}
