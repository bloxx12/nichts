{ inputs, outputs, pks, lib, profile-config, ... }:
{
  imports = [
  ../../../modules/vali/default.nix
  ../../common
  ./hardware-configuration.nix
  ./packages.nix
  ./boot.nix
  ];
  i3wm.enable = true; 
  security.polkit.enable = true;
  # Set the keyboard layout to DE
  services.xserver.xkb.layout.enable = "de";
  console.keyMap = "de";
}

