{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.theming.gtk;
  inherit (config.modules.other.system) username;
in {
  options.modules.theming.gtk = {
    enable = mkEnableOption "gtk theming";
    name = mkOption {
      description = "gtk theme name";
      type = types.str;
    };
    package = mkOption {
      description = "gtk theme package";
      type = types.package;
    };
    #  iconTheme = mkOption {
    #      description = "gtk icon theme";
    #      type = with types; submodule {
    #          options = {
    #              name = mkOption {
    #                  description = "gtk icon theme name";
    #                  type = str;
    #              };
    #              package = mkOption {
    #                  description = "gtk icon theme package";
    #                  type = package;
    #              };
    #          };
    #      };
    #  };
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      gtk = {
        enable = true;
        # theme = {
        # package = pkgs.gruvbox-gtk-theme;
        # name = "Gruvbox-Dark-BL";
        # };
        iconTheme = {
          name = "Papirus-Dark";
          package = pkgs.catppuccin-papirus-folders;
        };
      };
      home.sessionVariables = {
        #GTK_THEME = "Gruvbox-Dark-BL";
        #       GTK_USE_PORTAL = "1";
      };
    };
  };
}
