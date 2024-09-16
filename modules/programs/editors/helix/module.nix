{
  config,
  lib,
  self',
  pkgs,
  ...
}: let
  cfg = config.modules.system.programs.editors.helix;
  inherit (config.modules.other.system) username;
  inherit (lib) mkIf;
in {
  imports = [./languages.nix];
  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.helix = {
        enable = true;
        package = self'.packages.helix;

        settings = {
          theme = "catppuccin_mocha";
          editor = {
            cursorline = true;
            color-modes = true;
            indent-guides.render = true;
            lsp.display-inlay-hints = true;
            line-number = "relative";
            true-color = true;
            auto-format = true;
            completion-timeout = 5;
            mouse = true;
            bufferline = "multiple";
            soft-wrap.enable = true;
            lsp.display-messages = true;
            cursor-shape = {insert = "bar";};
            statusline.left = ["spinner" "version-control" "file-name"];
            inline-diagnostics = {
              cursor-line = "hint";
              other-lines = "error";
            };
          };
          keys.normal = {
            C-g = [":new" ":insert-output ${pkgs.gitui}" ":buffer-close!" ":redraw"];
            esc = ["collapse_selection" "keep_primary_selection"];
            A-H = "goto_previous_buffer";
            A-L = "goto_next_buffer";
            A-w = ":buffer-close";
            A-f = ":format";
          };
        };
      };
    };
  };
}
