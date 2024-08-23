{lib, ...}: let
  inherit (lib) mkOption;
  inherit (lib.types) package listOf;
in {
  options.modules.system.fonts = {
    # This defines extra fonts to be installed on the system.
    extraFonts = mkOption {
      type = listOf package;
      default = [];
    };
  };
}
