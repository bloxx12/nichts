{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.system.programs.editors.helix;
  inherit (config.modules.other.system) username;
  inherit (lib) mkIf getExe makeBinPath;
in {
  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.helix = {
        enable = true;
        # thanks fuf, this is great!
        package = pkgs.helix.overrideAttrs (previousAttrs: {
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
                typst-lsp
              ])
            ];
        });
        settings = {
          editor = {
            indent-guides.render = true;
            lsp.display-inlay-hints = true;
            line-number = "relative";
            mouse = true;
            bufferline = "multiple";
            soft-wrap.enable = true;
            lsp.display-messages = true;
            cursor-shape = {insert = "bar";};
            statusline.left = ["mode" "spinner" "version-control" "file-name"];
          };
          keys.normal = {
            C-g = [":new" ":insert-output lazygit" ":buffer-close!" ":redraw"];
            esc = ["collapse_selection" "keep_primary_selection"];
            A-H = "goto_previous_buffer";
            A-L = "goto_next_buffer";
            A-w = ":buffer-close";
          };
        };
        languages = {
          language-server = {
            nil = {
              command = getExe pkgs.nil;
              config.nil.formatting.command = ["${getExe pkgs.alejandra}" "-q"];
            };
          };
        };
      };
    };
  };
}
