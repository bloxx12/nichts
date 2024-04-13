{
    config,
    lib,
    pkgs,
    ...
}: with lib; let
    cfg = config.modules.programs.zathura;
    username = config.modules.other.system.username;
in {
    options.modules.programs.zathura.enable = mkEnableOption "zathura";

    config = mkIf cfg.enable {
        home-manager.users.${username} = {
            xdg.configFile."zathura/catppuccin-mocha".source = pkgs.fetchurl {
              url = "https://raw.githubusercontent.com/catppuccin/zathura/main/src/catppuccin-mocha";
              hash = "sha256-/HXecio3My2eXTpY7JoYiN9mnXsps4PAThDPs4OCsAk=";
            };

            programs.zathura = {
                enable = true;
                extraConfig = ''
                    include catppuccin-mocha
                '';
                options = {
                    selection-clipboard = "clipboard";
                };
            };
        };
    };
}
