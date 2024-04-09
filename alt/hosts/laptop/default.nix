{ inputs, outputs, pks, profile-config, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../common
    ./packages.nix
  ];
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  security.polkit.enable = true;
}
