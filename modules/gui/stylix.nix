{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.modules.programs.stylix;
  username = config.modules.other.system.username;
in {
  options.modules.programs.stylix.enable = mkEnableOption "stylix";

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      stylix = {
        polarity = "dark";
        image = ../../lib/wallpapers/mafu_trad_wall.png;
        base16Scheme =
          "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
        autoEnable = true;
        targets = {
          btop.enable = true;
          fish.enable = true;
          dunst.enable = true;
          emacs.enable = true;
          firefox.enable = true;
          kitty.enable = true;
          lazygit.enable = true;
          rofi.enable = true;
          foot.enable = true;
          tmux.enable = true;
          waybar.enable = true;
          vim.enable = true;
          zathura.enable = true;
          gtk.enable = true;
          hyprland.enable = true;
        };
        opacity = {
          applications = 0.9;
          popups = 0.9;
          desktop = 0.9;
          terminal = 0.9;
        };
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
              (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
            name = "JetBrainsMono";
          };
          serif = {
            package =
              (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
            name = "JetBrainsMono";
          };
          sansSerif = {
            package =
              (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
            name = "JetBrainsMono";
          };
          emoji = {
            package = pkgs.noto-fonts-emoji;
            name = "Noto Color Emoji";
          };
        };
      };
    };
    stylix = {
      image = ../../lib/wallpapers/FreeBSD.png;
      polarity = "dark";
    };
  };
}
