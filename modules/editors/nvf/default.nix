{
  pkgs,
  config,
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
    ignoredPaths ? [./nvf.nix ./plugins/sources/default.nix ./plugins],
  }:
    filter (hasSuffix ".nix") (
      map toString (
        filter (path: path != ./default.nix && !elem path ignoredPaths) (listFilesRecursive path)
      )
    );

  nvf = inputs.neovim-flake;
in {
  environment.systemPackages = with pkgs; [
    typstyle
  ];
  imports = concatLists [
    # neovim-flake home-manager module
    [nvf.nixosModules.default]
    # [./plugins/settings/ui.nix]
    # [./plugins/settings/filetree.nix]
    # [
    #   ./plugins/settings/autocomplete.nix
    #   ./plugins/settings/visuals.nix
    #   ./plugins/settings/autopairs.nix
    #   ./plugins/settings/binds.nix
    #   ./plugins/settings/comments.nix
    #   ./plugins/settings/dashboard.nix
    #   ./plugins/settings/debugger.nix
    #   ./plugins/settings/languages.nix
    #   ./plugins/settings/lsp.nix
    #   ./plugins/settings/telescope.nix
    #   ./plugins/settings/notes.nix
    #   ./plugins/settings/notify.nix
    #   ./plugins/settings/projects.nix
    #   ./plugins/settings/statusline.nix
    #   ./plugins/settings/tabline.nix
    #   ./plugins/settings/theme.nix
    #   ./plugins/settings/treesitter.nix
    #   ./plugins/settings/utility.nix
    #   ./plugins/settings/git.nix
    # construct this entore directory as a module
    # which means all default.nix files will be imported automtically
    (mkNeovimModule {path = ./.;})
  ];
}
