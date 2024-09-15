{
  inputs,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) concatStringsSep mapAttrsToList;
  aliases = import ./aliases.nix {inherit pkgs;};

  aliasesAsString =
    concatStringsSep "\n"
    (mapAttrsToList (k: v: "alias ${k}=\"${v}\"") aliases);
  packages = import ./packages.nix {inherit pkgs;};

  nushell-wrapped = inputs.wrapper-manager.lib.build {
    inherit pkgs;
    modules = [
      {
        wrappers.nushell-wrapped = {
          basePackage = pkgs.nushell;
          pathAdd = packages;
        };
      }
    ];
  };
in
  nushell-wrapped
