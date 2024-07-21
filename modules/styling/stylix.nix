{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: let
  cfg = config.modules.theming.stylix;
  inherit (config.modules.usrEnv.style.stylix) scheme image cursor fontsizes;
  inherit (lib) mkIf;
in {
  imports = [inputs.stylix.nixosModules.stylix];
  config = mkIf cfg.enable {
    stylix = {
      enable = true;
      homeManagerIntegration.followSystem = true;
      base16Scheme = scheme;
      inherit image;
      polarity = "dark";
      autoEnable = true;
      cursor = {
        inherit (cursor) size package name;
        # package = pkgs.bibata-cursors;
        # name = "Bibata-Modern-Classic";
      };
      fonts = {
        sizes = {
          inherit (fontsizes) terminal popups applications;
        };
        monospace = {
          package =
            pkgs.nerdfonts.override {fonts = ["JetBrainsMono" "ComicShannsMono"];};
          # name = "JetBrainsMono";
          name = "ComicShannsMono Nerd Font";
        };

        serif = config.stylix.fonts.monospace;
        sansSerif = config.stylix.fonts.monospace;

        # serif = {
        #
        #   package = pkgs.noto-fonts;
        #   name = "Noto Serif";
        # };
        # sansSerif = {
        #   package = pkgs.lexend;
        #   name = "Lexend";
        # };
        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };
      };
      opacity = {
        applications = 0.9;
        popups = 0.9;
        desktop = 0.9;
        terminal = 1.0;
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
        plymouth.enable = true;
        plymouth.logoAnimated = true;
      };
    };
  };
}
