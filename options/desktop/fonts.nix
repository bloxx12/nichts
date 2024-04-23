{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    material-design-icons
    (nerdfonts.override {
       # fonts = [ "JetBrains Mono"];
      })
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji
  ];
}
