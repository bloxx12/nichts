{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.types) optional;
  inherit (config.modules.system.fonts) extraFonts;
in {
  # A (somewhat) sane list of default fonts to be installed.
  fonts.packages = with pkgs;
    [
      material-design-icons
      papirus-icon-theme
      (nerdfonts.override {fonts = ["ComicShannsMono"];}) # ComicShanns my beloved
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      corefonts
    ]
    ++ optional (extraFonts != null) extraFonts;
}
