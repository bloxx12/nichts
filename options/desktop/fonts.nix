{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      material-design-icons
      xfce.xfce4-icon-theme
      papirus-icon-theme
      (nerdfonts.override {fonts = ["JetBrainsMono" "ComicShannsMono"];})
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      corefonts
    ];
    # What does this do?
    # fonts.enableDefaultPackages: when set to true,
    # causes some "basic" fonts to be installed for reasonable Unicode coverage.
    # Set to true if you are unsure about what languages you
    # might end up reading.
    enableDefaultPackages = false;

    # this fixes emoji stuff
    # fontconfig = {
    #   defaultFonts = {
    #     #monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
    #
    #     monospace = ["ComicShannsMono Nerd Font" "Noto Color Emoji"];
    #     sansSerif = ["Lexend" "Noto Color Emoji"];
    #     serif = ["Noto Serif" "Noto Color Emoji"];
    #     emoji = ["Noto Color Emoji"];
    #   };
    # };
  };
}
