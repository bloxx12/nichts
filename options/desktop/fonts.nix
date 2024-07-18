{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      material-icons
      material-design-icons
      (nerdfonts.override {fonts = ["Iosevka" "JetBrainsMono" "ComicShannsMono"];})
      noto-fonts
      noto-fonts-cjk
      noto-fonts-cjk
      noto-fonts-emoji
      jetbrains-mono
      lexend
      emacs-all-the-icons-fonts
    ];
    # What does this do?
    enableDefaultPackages = false;

    # this fixes emoji stuff
    fontconfig = {
      defaultFonts = {
        #monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];

        monospace = ["ComicShannsMono Nerd Font" "Noto Color Emoji"];
        sansSerif = ["Lexend" "Noto Color Emoji"];
        serif = ["Noto Serif" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
