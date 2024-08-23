{
  lib,
  inputs,
  ...
}: let
  inherit (builtins) filter map toString elem;
  inherit (lib.filesystem) listFilesRecursive;
  inherit (lib.strings) hasSuffix;
  inherit (lib.lists) concatLists;

  mkNeovimModule = {
    path,
    ignoredPaths ? [],
  }:
    filter (hasSuffix ".nix") (
      map toString (
        filter (path: path != ./default.nix && !elem path ignoredPaths) (listFilesRecursive path)
      )
    );

  nvf = inputs.neovim-flake;
in {
  imports = concatLists [
    # neovim-flake home-manager module
    [nvf.nixosModules.default]
    # construct this entire directory as a module
    # which means all default.nix files will be imported automtically
    (mkNeovimModule {path = ./.;})
  ];
}
