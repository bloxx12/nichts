pkgs: let
  helix = pkgs.callPackage ./helix.nix {};
  kakoune = null;
  fish = pkgs.callPackage ./shell {};
in {
  inherit helix kakoune fish;
}
