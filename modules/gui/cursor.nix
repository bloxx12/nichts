{
    config,
    lib,
    ...
}: with lib; let
    cfg = config.modules.themes.cursor;
    username = config.modules.other.system.username;
in {
    options.modules.themes.cursor = {
        enable = mkEnableOption "cursor theming";
        package = mkOption {
            description = "cursor theme package";
            type = types.package;
        };
        name = mkOption {
            description = "cursor theme name";
            type = types.str;
        };
        size = mkOption {
            description = "cursor size";
            type = types.int;
        };
    };

    config = mkIf cfg.enable {
        environment.sessionVariables = {
            XCURSOR_THEME = "${cfg.name}";
            XCURSOR_SIZE = "${toString cfg.size}";
        };

        home-manager.users.${username} = {
            home.pointerCursor = {
                inherit (cfg) package name size;
                gtk.enable = true;
                x11.enable = true;
            };
        };
    };
}
