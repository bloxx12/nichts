# NOTE: This module is entirely inspired by raf,
# most of the nix code is also taken from him,
# so please do check out his configuration!
# raf himself took it from misterio77
# and adapted it for his personal use,
# so look there too.
# <https://github.com/Misterio77/nix-colors/blob/main/module/colorscheme.nix>
{
  config,
  lib,
  ...
}: let
  inherit (lib.options) mkOption literalExpression;
  inherit (lib.types) str nullOr enum mkOptionType attrsOf coercedTo;
  inherit (lib.strings) toLower replaceStrings removePrefix hasPrefix isString;
  # inherit (lib) serializeTheme;

  cfg = config.modules.style;

  hexColorType = mkOptionType {
    name = "hex-color";
    descriptionClass = "noun";
    description = "RGB color in hex format";
    check = x: isString x && !(hasPrefix "#" x);
  };
  colorType = attrsOf (coercedTo str (removePrefix "#") hexColorType);

  nameToSlug = name: toLower (replaceStrings [" "] ["-"] name);
  getPaletteFromScheme = slug:
    if builtins.pathExists ./palettes/${slug}.nix
    then (import ./palettes/${slug}.nix).colorscheme.palette
    else throw "The following colorscheme was imported but not found: ${slug}";
in {
  options.modules.style = {
    colorScheme = {
      name = mkOption {
        type = nullOr (enum ["Catppuccin Mocha" "Tokyonight Storm" "Oxocarbon Dark"]);
        description = "The colorscheme that should be used globally to theme your system.";
        default = "Catppuccin Mocha";
      };

      slug = mkOption {
        type = str;
        default = nameToSlug "${toString cfg.colorScheme.name}"; # toString to avoid type errors if null, returns ""
        description = ''
          The serialized slug for the colorScheme you are using.

          Defaults to a lowercased version of the theme name with spaces
          replaced with hyphens.

          Must only be changed if the slug is expected to be different than
          the serialized theme name."
        '';
      };

      colors = mkOption {
        type = colorType;
        default = getPaletteFromScheme cfg.colorScheme.slug;
        description = ''
          An attribute set containing active colors of the system. Follows base16
          scheme by default but can be expanded to base24 or anything "above" as
          seen fit as the module option is actually not checked in any way
        '';
        example = literalExpression ''
          {
              base00 = "#1e1e2e"; # Base
              base01 = "#181825"; # Mantle
              base02 = "#313244"; # Surface0
              base03 = "#45475a"; # Surface1
              base04 = "#585b70"; # Surface2
              base05 = "#cdd6f4"; # text
              base06 = "#f5e0dc"; # rosewater
              base07 = "#b4befe"; # lavender
              base08 = "#f38ba8"; # red
              base09 = "#fab387"; # peach
              base0A = "#a6e3a1"; # yellow
              base0B = "#94e2d5"; # green
              base0C = "#94e2d5"; # teal
              base0D = "#89b4fa"; # blue
              base0E = "#cba6f7"; # mauve
              base0F = "#f2cdcd"; # flamingo
          }
        '';
      };

      variant = mkOption {
        type = enum ["dark" "light"];
        default =
          if builtins.substring 0 1 cfg.colorScheme.colors.base00 < "5"
          then "dark"
          else "light";
        description = ''
          Whether the scheme is dark or light
        '';
      };
    };
  };
}
