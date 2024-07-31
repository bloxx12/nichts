{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: let
  cfg = config.modules.usrEnv.style.stylix;
  inherit (config.modules.usrEnv.style.stylix) scheme image cursor fontsizes;
  inherit (config.modules.other.system) username;
  inherit (lib) mkIf;
in {
  imports = [inputs.stylix.nixosModules.stylix];
  config = mkIf cfg.enable {
    stylix = {
      enable = true;
      autoEnable = false;
      homeManagerIntegration = {
        followSystem = true;
        autoImport = true;
      };
      base16Scheme = scheme;
      inherit image;
      polarity = "dark";
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
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
      };
      opacity = {
        applications = 1.0;
        popups = 1.0;
        desktop = 1.0;
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
        plymouth.enable = true;
        plymouth.logoAnimated = true;
      };
    };
    home-manager.users.${username} = {
      stylix.targets = {
        btop.enable = true;
        helix.enable = true;
        dunst.enable = true;
        firefox.enable = true;
        foot.enable = true;
        fzf.enable = true;
        hyprland.enable = true;
        lazygit.enable = true;
        zellij.enable = true;
      };
    };
  };
}
