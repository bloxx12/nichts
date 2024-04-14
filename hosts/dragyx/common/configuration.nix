{ config, pkgs, ... }:

{
  imports = [
    ../../../options/common/pin-registry.nix
    ../../../options/common/preserve-system.nix
    ../../../options/desktop/fonts.nix
  ];


  services.locate = {
    enable = true;
    interval = "hourly";
    package = pkgs.plocate;
    localuser = null;
  };


}
