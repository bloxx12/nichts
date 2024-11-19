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
  cfg = config.modules.usrEnv.style.qt;
in {
  config = mkIf cfg.enable {
    environment.sessionVariables = {QT_QPA_PLATFORMTHEME = "qt5ct";};

    environment.variables = {
      QT_STYLE_OVERRIDE = lib.mkForce "kvantum";
      GTK_THEME = theme.name;
    };
  };
}
