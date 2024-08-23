{
  config,
  lib,
  pkgs,
  ...
}: let
  xanmod_custom = callPackage ./xanmod.nix;
in {
  boot.kernelPackages = xanmod_custom;
}
