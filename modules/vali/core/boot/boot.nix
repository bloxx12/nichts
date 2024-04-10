{ inputs, outputs, profile-config, pkgs, ... }:

{
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
      };
   };
}
