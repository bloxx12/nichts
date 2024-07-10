{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.modules.theming.stylix;
  inherit (config.modules.theming.stylix) scheme image;
  inherit (config.modules.theming.stylix.cursor) size;
  inherit (config.modules.theming.stylix.fontsizes) terminal popups applications;
in {
  options.modules.theming.stylix = {
    enable = lib.mkEnableOption "stylix";
    scheme = lib.mkOption {
      description = " Color Scheme";
      type = lib.types.str;
    };
    image = lib.mkOption {
      description = "Image";
      type = lib.types.path;
    };
    cursor = {
      size = lib.mkOption {
        description = "Cursor Size";
        type = lib.types.int;
      };
      package = lib.mkOption {
        description = "Cursor Package";
        type = lib.types.package;
      };
      name = lib.mkOption {
        description = "Cursor Name";
        type = lib.type.str;
      };
    };
    fontsizes = {
      terminal = lib.mkOption {
        description = "Terminal font size";
        type = lib.types.int;
      };
      popups = lib.mkOption {
        description = "Popup font size";
        type = lib.types.int;
      };
      applications = lib.mkOption {
        description = "Application font size";
        type = lib.types.int;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      homeManagerIntegration.followSystem = true;
      base16Scheme = scheme;
      inherit image;
      polarity = "dark";
      autoEnable = true;
      cursor = {
        inherit size;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
      };
      fonts = {
        sizes = {
          inherit terminal popups applications;
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
        plymouth.enable = true;
        plymouth.logoAnimated = true;
      };
    };
  };
}
