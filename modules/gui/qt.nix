{
    config,
    lib,
    pkgs,
    ...
}: with lib; let
    cfg = config.myOptions.themes.qt;
    username = config.myOptions.other.system.username;
in {
    options.myOptions.themes.qt = {
        enable = mkEnableOption "qt theming";
        name = mkOption {
            description = "qt theme name";
            type = types.str;
        };
        variant = mkOption {
            description = "qt theme variant";
            type = types.str;
        };
        accentColour = mkOption {
            description = "accent colour for qt theme";
            type = types.str;
        };
        package = mkOption {
            description = "qt theme package";
            type = types.package;
        };
    };

    config = mkIf cfg.enable {
        environment.sessionVariables = {
            QT_QPA_PLATFORMTHEME = "qt5ct";
        };

        home-manager.users.${username} = {
            # thanks raf :3 https://github.com/NotAShelf/nyx/blob/main/homes/notashelf/themes/qt.nix
            qt = {
                enable = true;
                platformTheme = "qtct";
                style = {
                    inherit (cfg) name;
                    package = cfg.package.override {
                        flavour = [ cfg.variant ];
                        accents = [ cfg.accentColour ];
                    };
                };
            };

            home = {
                packages = with pkgs; [
                    qt5.qttools
                    qt6Packages.qtstyleplugin-kvantum
                    libsForQt5.qtstyleplugin-kvantum
                    libsForQt5.qt5ct
                    breeze-icons
                ];

                sessionVariables = {
                    #QT_STYLE_OVERRIDE = "kvantum";
                    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
#                    QT_QPA_PLATFORM = "wayland;xcb";
#                    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
                    DISABLE_QT_COMPAT = "0";
                };
            };

            # TODO somehow make this configurable IDK
            xdg.configFile = {
                "Kvantum/catppuccin/catppuccin.kvconfig".source = pkgs.fetchurl {
                    url = "https://raw.githubusercontent.com/catppuccin/Kvantum/main/src/Catppuccin-Mocha-Green/Catppuccin-Mocha-Green.kvconfig";
                    sha256 = "16ry4k09nf5w1gyawwz2ny14zn6infqk40l35lqlg30lhgbdmr5f";
                };
                "Kvantum/catppuccin/catppuccin.svg".source = pkgs.fetchurl {
                    url = "https://raw.githubusercontent.com/catppuccin/Kvantum/main/src/Catppuccin-Mocha-Green/Catppuccin-Mocha-Green.svg";
                    sha256 = "1djh625qag34rjsp7y67nzbi9nbmiwgq63ydfizsh65n3fyfakf1";
                };
                "Kvantum/kvantum.kvconfig".text = ''
                    [General]
                    theme=catppuccin

                    [Applications]
                    catppuccin=qt5ct, org.qbittorrent.qBittorrent, hyprland-share-picker
                '';
            };
        };
    };
}
