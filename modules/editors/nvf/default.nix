{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  cfg = config.modules.system.programs.editors.neovim;
  inherit (builtins) filter map toString elem;
  inherit (lib.filesystem) listFilesRecursive;
  inherit (lib.strings) hasSuffix;
  inherit (lib.lists) concatLists;
  inherit (lib) mkIf;

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
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      typstyle
    ];
  };
  imports = concatLists [
    # neovim-flake home-manager module
    [nvf.nixosModules.default]
    # construct this entire directory as a module
    # which means all default.nix files will be imported automtically
    (mkNeovimModule {path = ./.;})
  ];
}
