# NOTE: This module is entirely inspired by raf,
# most of the nix code is also taken from him,
# so please do check out his configuration!
{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOptionType isString mkOption;
  inherit (lib.strings) replaceStrings hasPrefix removePrefix toLower;
  inherit (lib.types) enum str coercedTo nullOr attrsOf;

  cfg = config.modules.style;

  nameToSlug = name: toLower (replaceStrings [" "] ["-"] name);

  hexColorType = mkOptionType {
    name = "hex-color";
    descriptionClass = "noun";
    description = "RGB color in hex format";
    check = x: isString x && !(hasPrefix "#" x);
  };

  colorType = attrsOf (coercedTo str (removePrefix "#") hexColorType);

  getPaletteFromScheme = slug:
    if builtins.pathExists ./palettes/${slug}.nix
    then (import ./palettes/${slug}.nix).colorscheme.palette
    else throw "The following colorscheme was imported but not found: ${slug}";
in {
  options.modules.style = {
    colorScheme = {
      name = mkOption {
        type = nullOr (enum ["Catppuccin Mocha" "Catppuccin Latte"]);
        default = "Catppuccin Mocha";
      };
      slug = {
        type = str;
        default = nameToSlug "${toString cfg.colorScheme.name}";
      };
      variant = {
      };
      colors = mkOption {
        type = colorType;
        default = getPaletteFromScheme cfg.colorScheme.slug;
      };
    };
  };
}
