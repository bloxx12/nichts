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
  cfg = config.modules.style.qt;
  inherit (config.modules.other.system) username;
in {
  config = mkIf cfg.enable {
    environment.sessionVariables = {QT_QPA_PLATFORMTHEME = "qt5ct";};

    environment.variables = {
      QT_STYLE_OVERRIDE = lib.mkForce "kvantum";
      GTK_THEME = theme.name;
    };

    home-manager.users.${username} = {
      # This is taken from jacekpoz, thanks a lot!
      qt = {
        enable = true;
        style = {
          inherit (cfg) name;
          package = cfg.package.override {
            flavour = [cfg.variant];
            accents = [cfg.accentColor];
          };
        };
      };
      home = {
        packages = with pkgs; [
          qt5.qttools
          qt6Packages.qtstyleplugin-kvantum
          libsForQt5.qtstyleplugin-kvantum
          libsForQt5.qt5ct
          breeze-icons
        ];

        sessionVariables = {
          # Scaling factor for QT applications
          QT_AUTO_SCREEN_SCALE_FACTOR = "1";

          # Use wayland as the default backend, fall back to xcb if not available
          QT_QPA_PLATFORM = "wayland;xcb";

          # Disable window decorations for qt applications
          QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

          # Remain compatible with QT5 whenever possible
          DISABLE_QT_COMPAT = "0";

          # Tell Calibre to use the dark theme, because the light one hurts my eyes.
          CALIBRE_USE_DARK_PALETTE = "1";
        };
      };
    };
  };
}
