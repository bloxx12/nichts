{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.system.programs.editors.helix;
  inherit (config.modules.other.system) username;
  inherit (lib) mkIf;
in {
  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.helix = {
        enable = true;
        settings = {
          editor = {
            line-number = "relative";
            mouse = false;
            bufferline = "multiple";
            soft-wrap.enable = true;
            lsp.display-messages = true;
            cursor-shape = {insert = "bar";};
            statusline.left = ["mode" "spinner" "version-control" "file-name"];
          };
          keys.normal = {
            C-g = [":new" ":insert-output lazygit" ":buffer-close!" ":redraw"];
            C-t = [":new" ":insert-output fish" ":buffer-close!" ":redraw"];
            esc = ["collapse_selection" "keep_primary_selection"];
            A-H = "goto_previous_buffer";
            A-L = "goto_next_buffer";
            A-w = ":buffer-close";
          };
        };
        languages.language = [
          {
            name = "nix";
            auto-format = true;
            formatter.command = "${pkgs.nixfmt-classic}/bin/nixfmt";
          }
        ];
      };
    };
  };
}
