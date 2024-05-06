{ config, pkgs, lib, ... }:
with lib; let
    cfg = config.modules.programs.stylix;
    username = config.modules.other.system.username;
in {
    options.modules.programs.stylix.enable = mkEnableOption "stylix";

    config = mkIf cfg.enable {
        home-manager.users.${username} = {
            stylix = {
                targets = {
                    btop.enable = true;
                    fish.enable = true;
                    emacs.enable = true;
                    firefox.enable = true;
                    kitty.enable = true;
                    lazygit.enable = true;
                    rofi.enable = true;
                    tmux.enable = true;
                    vim.enable = true;
                    zathura.enable = true;
                    gtk.enable = true;
                    hyprland.enable = true;
                };
            };
        };
        stylix = {
            autoEnable = true;
            base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-soft.yaml";
            polarity = "dark";
            image = ../../hosts/vali/mars/2024-04-21-14-50.png;
            cursor = {
              package = pkgs.bibata-cursors;
              name = "Bibata-Modern-Classic";
              size = 24;
            };
            targets.plymouth.enable = true;
            opacity = {
                applications = 0.7;
                popups = 0.7;
                desktop = 0.7;
            };
            fonts = {
                sizes = {
                    terminal = 14;
                    popups = 14;

                };
                monospace = {
                    package = (pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];});
                    name = "JetBrainsMono";
                };
                serif = {
                    package = (pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];});
                    name = "JetBrainsMono";
                };
                sansSerif = {
                    package = (pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];});
                    name = "JetBrainsMono";
                };
                emoji = {
                    package = pkgs.noto-fonts-emoji;
                    name = "Noto Color Emoji";
                };
            };

        };
    };
}