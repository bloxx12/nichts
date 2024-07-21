{
  config,
  lib,
  ...
}: let
  inherit (lib) types mkEnableOption mkOption;
in {
  options.modules.usrEnv.style.stylix = {
    enable = mkEnableOption "Stylix style Manager";
    scheme = mkOption {
      description = "Color Scheme";
      type = types.str;
    };
    image = mkOption {
      description = "Image";
      type = types.path;
    };
    cursor = {
      size = mkOption {
        description = "Cursor Size";
        type = types.int;
      };
      package = mkOption {
        description = "Cursor Package";
        type = types.package;
      };
      name = mkOption {
        description = "Cursor Name";
        type = types.str;
      };
    };
    fontsizes = {
      terminal = mkOption {
        description = "Terminal font size";
        type = types.int;
      };
      popups = mkOption {
        description = "Popup font size";
        type = types.int;
      };
      applications = mkOption {
        description = "Application font size";
        type = types.int;
      };
    };
  };
}
