{ pkgs, lib, config, ...}:

{
  options = {
    i3wm.enable = lib.mkEnableOption "enable i3wm";
    };
  config = lib.mkIf config.i3wm.enable {
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
