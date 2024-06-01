{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.modules.programs.stylix;
  inherit (config.modules.other.system) username;
in {
  options.modules.programs.stylix.enable = lib.mkEnableOption "stylix";
  config = lib.mkIf cfg.enable {
    stylix = {
      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-pale.yaml";
      image = ../../assets/wallpapers/tiredgod.png;
      polarity = "dark";
      autoEnable = true;
      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 24;
      };
      fonts = {
        sizes = {
          terminal = 14;
          popups = 14;
        };
        monospace = {
          package =
            pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
          name = "JetBrainsMono";
        };
        serif = {
          package = pkgs.noto-fonts;
          name = "Noto Serif";
        };
        sansSerif = {
          package = pkgs.lexend;
          name = "Lexend";
        };
        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };
      };
      opacity = {
        applications = 0.9;
        popups = 0.9;
        desktop = 0.9;
        terminal = 0.85;
      };
      targets = {
        console.enable = true;
        fish.enable = true;
        grub.enable = false;
        grub.useImage = true;
        gtk.enable = true;
        lightdm.enable = true;
        nixos-icons.enable = true;
        nixvim.enable = true;
        plymouth.logoAnimated = true;
      };
    };
  };
}
