{ config, pkgs, callPackage, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ../common
  ];
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
    displayManager.defaultSession = "xfce";
    windowManager.i3.enable = true;
  };
  ...
}
