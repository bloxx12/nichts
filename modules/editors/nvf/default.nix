{
  inputs,
  lib,
  ...
}: let
  inherit (builtins) filter map toString elem;
  inherit (lib.filesystem) listFilesRecursive;
  inherit (lib.strings) hasSuffix;
  inherit (lib.lists) concatLists;

  mkNeovimModule = {
    path,
    ingoredPaths ? [./nvf.nix],
  }:
    filter (hasSuffix ".nix") (
      map toString (
        filter (path: path != ./default.nix && !elem path ingoredPaths) (listFilesRecursive path)
      )
    );

  nvf = inputs.neovim-flake;
in {
  imports = concatLists [
    # neovim-flake home-manager module
    [nvf.homeManagerModules.default]

    # construct this entore directory as a module
    # which means all default.nix files will be imported automtically
    (mkNeovimModule {path = ./.;})
  ];
}
