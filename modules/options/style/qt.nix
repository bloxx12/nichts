{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkOption;
  inherit (lib.types) str package;
in {
  options.modules.usrEnv.style.qt = {
    enable = mkEnableOption "qt theming";
    name = mkOption {
      description = "qt theme name";
      default = "Catppuccin-Mocha-Dark";
      type = str;
    };
    variant = mkOption {
      description = "qt theme variant";
      default = "mocha";
      type = str;
    };
    accentColor = mkOption {
      description = "accent colour for qt theme";
      default = "green";
      type = str;
    };
    package = mkOption {
      description = "qt theme package";
      default = pkgs.catppuccin-kde;
      type = package;
    };
  };
}
