{
  config,
  lib,
  ...
}: let
inherit (lib) mkOption;
inherit (lib.types) str;
in {
  options.modules.style = {
    colorScheme = {
      name = mkOption {
type = str;
default = "catppuccin-mocha";
      };
      slug = {
      };
      variant = {
      };
      colors = mkOption {
        
      };
    };
  };
}
