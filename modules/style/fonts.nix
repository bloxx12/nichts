{pkgs, ...}: let
  inherit (builtins) mapAttrs;

  custom-iosevka = pkgs.iosevka.override {
    privateBuildPlan = {
      family = "Iosevka Custom";
      spacing = "normal";
      serifs = "sans";

      noCvSs = true;
      exportGlyphNames = false;
      variants.inherits = "ss15";
      ligations.inherits = "dlig";
    };
    set = "Fancy";
  };
in {
  # A (somewhat) sane list of fonts to be installed.
  fonts = {
    fontconfig = {
      # Whether to enable fontconfig configuration. This will, for
      # example, allow fontconfig to discover fonts and configurations
      # installed through home.packages and nix-env.
      enable = true;

      # Enable font antialiasing.
      antialias = true;

      #  Enable font hinting. Hinting aligns glyphs to pixel boundaries
      # to improve rendering sharpness at low resolution.
      hinting.enable = true;
      # Set the defalt fonts. This was taken from raf,
      # many thanks.
      defaultFonts = let
        common = [
          "Iosevka Nerd Font"
          "Roboto Mono Nerd Font"
          "Fira Code Nerd Font"
          "Symbols Nerd Font"
          "Noto Color Emoji"
        ];
      in
        mapAttrs (_: fonts: fonts ++ common) {
          serif = ["Noto Serif"];
          sansSerif = ["Lexend"];
          emoji = ["Noto Color Emoji"];
          monospace = ["Iosevka Nerd Font"];
        };
    };
    packages = with pkgs; [
      # custom-iosevka
      material-icons
      material-design-icons
      papirus-icon-theme
      nerd-fonts.iosevka
      nerd-fonts.jetbrains-mono
      nerd-fonts.comic-shanns-mono
      nerd-fonts.symbols-only
      

      lexend
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      corefonts
    ];
    fontDir = {
      # Whether to create a directory with links to all fonts in
      # /run/current-system/sw/share/X11/fonts
      enable = true;

      # Whether to decompress fonts in
      # /run/current-system/sw/share/X11/fonts
      decompressFonts = true;
    };
  };
}
