{lib, ...}: let
  inherit (lib) mkOption;
  inherit (lib.types) str;
in {
  options.modules.style = {
    colorScheme = {
      name = mkOption {
        type = str;
        default = "Catppuccin Mocha";
      };
      slug = {
        type = str;
        default = "catppuccin-mocha";
      };
      variant = {
      };
      colors =
        mkOption {
        };
    };
  };
}
