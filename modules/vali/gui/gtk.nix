{
    config,
    lib,
    ...
}: with lib; let
    cfg = config.myOptions.themes.gtk;
    username = config.myOptions.other.system.username;
    hmCfg = config.home-manager.users.${username};
in {
    options.myOptions.themes.gtk = {
        enable = mkEnableOption "gtk theming";
        name = mkOption {
            description = "gtk theme name";
            type = types.str;
        };
        variant = mkOption {
            description = "gtk theme variant";
            type = types.str;
        };
        accentColour = mkOption {
            description = "accent colour for gtk theme";
            type = types.str;
        };
        package = mkOption {
            description = "gtk theme package";
            type = types.package;
        };
        iconTheme = mkOption {
            description = "gtk icon theme";
            type = with types; submodule {
                options = {
                    name = mkOption {
                        description = "gtk icon theme name";
                        type = str;
                    };
                    package = mkOption {
                        description = "gtk icon theme package";
                        type = package;
                    };
                };
            };
        };
    };

    config = mkIf cfg.enable {
        home-manager.users.${username} = {
            gtk = {
                enable = true;
                theme = {
                    inherit (cfg) name;
                    package = cfg.package.override {
                        size = "standard";
                        accents = [ cfg.accentColour ];
                        inherit (cfg) variant;
                        tweaks = [ "normal" ];
                    };
                };
                iconTheme = {
                    inherit (cfg.iconTheme) name;
                    package = cfg.iconTheme.package.override {
                        accent = cfg.accentColour;
                        flavor = cfg.variant;
                    };
                };
                gtk2 = {
                    configLocation = "${hmCfg.xdg.configHome}/gtk-2.0/gtkrc";
                };
            };
            home.sessionVariables = {
                GTK_THEME = cfg.name;
                GTK_USE_PORTAL = "1";
            };
        };
    };
}
