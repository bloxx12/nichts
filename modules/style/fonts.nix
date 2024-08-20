{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.modules.system.fonts) extraFonts;
  inherit (config.modules.other.system) username;
in {
  # A (somewhat) sane list of default fonts to be installed.
  fonts.packages = with pkgs;
    [
      etBook
      material-design-icons
      papirus-icon-theme
      (nerdfonts.override {fonts = ["ComicShannsMono"];}) # ComicShanns my beloved
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      corefonts
    ]
    ++ extraFonts;
  # this fixes emoji stuff
  home-manager.users.${username} = {
    fonts.fontconfig = {
      defaultFonts = {
        monospace = ["ComicShannsMono Nerd Font" "Noto Color Emoji"];
        sansSerif = ["ComicShannsMono Nerd Font" "Noto Color Emoji"];
        serif = ["ComicShannsMono Nerd Font" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
