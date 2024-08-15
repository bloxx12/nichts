{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (config.modules.other.system) username;
  inherit (lib) mkOption mkEnableOption;
  inherit (lib.types) str package submodule;
in {
  options.modules.style.gtk = {
    enable = mkEnableOption "Wether to enable GTK theming";
    theme = {
      name = mkOption {
        description = "The GTK theme name";
        default = "Gruvbox-Dark-BL";
        type = str;
      };
      package = mkOption {
        description = "The GTK theme package";
        default = pkgs.gruvbox-gtk-theme;
        type = package;
      };
    };
    iconTheme = mkOption {
      description = "The GTK icon theme";
      type = submodule {
        options = {
          name = mkOption {
            description = "The GTK icon theme name";
            default = "Papirus-Dark";
            type = str;
          };
          package = mkOption {
            description = "The GTK icon theme package";
            default = pkgs.catppuccin-papirus-folders;
            type = package;
          };
        };
      };
    };
  };
}
