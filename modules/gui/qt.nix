{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  theme = {
    package = pkgs.gruvbox-gtk-theme;
    name = "Gruvbox-Dark-BL";
  };
  cfg = config.modules.themes.qt;
  inherit (config.modules.other.system) username;
in {
  options.modules.themes.qt = {
    enable = mkEnableOption "qt theming";
    name = mkOption {
      description = "qt theme name";
      type = types.str;
    };
    variant = mkOption {
      description = "qt theme variant";
      type = types.str;
    };
    accentColour = mkOption {
      description = "accent colour for qt theme";
      type = types.str;
    };
    package = mkOption {
      description = "qt theme package";
      type = types.package;
    };
  };

  config = mkIf cfg.enable {
    environment.sessionVariables = {QT_QPA_PLATFORMTHEME = "qt5ct";};
    environment.variables = {
      QT_STYLE_OVERRIDE = lib.mkForce "kvantum";
      GTK_THEME = theme.name;
    };

    home-manager.users.${username} = {
      qt = {
        enable = true;
        platformTheme.name = "qt5ct";
        # style = {
        #     inherit (cfg) name package;
        # };
      };
      home = {
        packages = with pkgs; [
          qt5.qttools
          libsForQt5.qt5ct
          libsForQt5.qtstyleplugin-kvantum
          breeze-icons
        ];
      };
    };
  };
}
