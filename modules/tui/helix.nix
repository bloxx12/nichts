{ config, lib, pkgs, inputs, ... }:
with lib; let
    cfg = config.modules.programs.helix;
    username = config.modules.other.system.username;
in  {
    options.modules.programs.helix.enable = mkEnableOption "helix";

    config = mkIf cfg.enable {
        home-manager.users.${username} = {
            programs.helix = {
                enable = true;
                settings = {
                    editor = {
                        line-number = "relative";
                        mouse = false;
                        bufferline = "multiple";
                        lsp.display-messages = true;
                        cursor-shape = {
                            insert = "bar";
                        };
                    };
                    keys.normal = {
                        C-g = [":new" ":insert-output lazygit" ":buffer-close!" ":redraw"];
                        esc = ["collapse_selection" "keep_primary_selection"];
                    };
                };
            };
        };
    };
}
