{
  config,
  inputs',
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.system.programs.editors.helix;
  inherit (config.modules.other.system) username;
  inherit (lib) mkIf getExe makeBinPath;
in {
  imports = [./languages.nix];
  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.helix = {
        enable = true;
        # thanks fufexan, this is great!
        package = inputs'.helix.packages.default.overrideAttrs (previousAttrs: {
          makeWrapperArgs = with pkgs;
            previousAttrs.makeWrapperArgs
            or []
            ++ [
              "--suffix"
              "PATH"
              ":"
              (makeBinPath [
                clang-tools
                marksman
                nil
                bash-language-server
                shellcheck
              ])
            ];
        });
        settings = {
          theme = "catppuccin_mocha";
          editor = {
            cursorline = true;
            color-modes = true;
            indent-guides.render = true;
            lsp.display-inlay-hints = true;
            line-number = "relative";
            true-color = true;
            mouse = true;
            bufferline = "multiple";
            soft-wrap.enable = true;
            lsp.display-messages = true;
            cursor-shape = {insert = "bar";};
            statusline.left = ["mode" "spinner" "version-control" "file-name"];
            inline-diagnostics = {
              cursor-line = "hint";
              other-lines = "error";
            };
          };
          keys.normal = {
            C-g = [":new" ":insert-output lazygit" ":buffer-close!" ":redraw"];
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
