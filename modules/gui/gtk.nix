{
    config,
    lib,
    pkgs,
    ...
}: with lib; let
    cfg = config.modules.themes.gtk;
    username = config.modules.other.system.username;
    hmCfg = config.home-manager.users.${username};
in {
    options.modules.themes.gtk = {
        enable = mkEnableOption "gtk theming";
        name = mkOption {
            description = "gtk theme name";
            type = types.str;
        };
        package = mkOption {
            description = "gtk theme package";
            type = types.package;
        };
      #  iconTheme = mkOption {
      #      description = "gtk icon theme";
      #      type = with types; submodule {
      #          options = {
      #              name = mkOption {
      #                  description = "gtk icon theme name";
      #                  type = str;
      #              };
      #              package = mkOption {
      #                  description = "gtk icon theme package";
      #                  type = package;
      #              };
      #          };
      #      };
      #  };
    };

    config = mkIf cfg.enable {
        home-manager.users.${username} = {
            gtk = {
                enable = true;
                theme = {
                #    inherit (cfg) name package;
                    package = pkgs.materia-theme;
                    name = "Materia-dark";
                };
              #  iconTheme = {
              #      inherit (cfg.iconTheme) name package;
              #  };
            };
         #   home.sessionVariables = {
         #       GTK_THEME = cfg.name;
         #       GTK_USE_PORTAL = "1";
         #   };
        };
    };
}
