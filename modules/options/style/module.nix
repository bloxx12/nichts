{
  lib,
  pkgs,
  config,
}: let
in {
  imports = [
    ./stylix.nix
    ./qt.nix
    ./gtk.nix
  ];
}
