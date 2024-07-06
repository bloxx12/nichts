{
  config,
  lib,
  inputs,
  ...
}: let
  inherit (builtins) filter map toString elem;
  inherit (lib.filesystem) listFilesRecursive;
  inherit (lib.strings) hasSuffix;
  inherit (lib.lists) concatLists;

  mkNixvimModule = {
    path,
    ignoredPaths ? [
    ],
  }:
    filter (hasSuffix ".nix") (
      map toString (
        filter (path: path != ./default.nix && !elem path ignoredPaths) (listFilesRecursive path)
      )
    );
in {
  imports = concatLists [
    [inputs.nixvim.nixosModules.nixvim]

    (mkNixvimModule {path = ./.;})
  ];
}
