{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkOption mkEnableOption;
  inherit (lib.types) str package;
in {
  options.modules.usrEnv.style.gtk = {
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
    iconTheme = {
      description = "The GTK icon theme";
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
}
