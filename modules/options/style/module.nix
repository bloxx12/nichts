{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkOption;
  inherit (lib.types) package str int;
in {
  imports = [
    ./qt.nix
    ./gtk.nix
  ];

  options.modules.style = {
    cursor = {
      package = mkOption {
        type = package;
        default = pkgs.bibata-cursors;
        description = "Cursor package";
      };
      name = mkOption {
        type = str;
        default = "Bibata-Modern-Classic";
        description = "Cursor name";
      };
      size = mkOption {
        type = int;
        default = 32;
        description = "Cursor size";
      };
    };
  };
}
