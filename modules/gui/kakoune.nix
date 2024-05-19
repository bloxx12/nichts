{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.programs.kakoune;
  username = config.modules.other.system.username;
  # inherit (inputs.kakoune.packages.${pkgs.system}) kakoun;
in {
  options.modules.programs.kakoune.enable = mkEnableOption "kakoune";

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.kakoune = {
        enable = true;
        # extraConfig = builtins.readFile
        # package = kakoun;
        plugins = with pkgs.kakounePlugins; [
          auto-pairs-kak
          fzf-kak
          powerline-kak
          byline-kak
          kakoune-lsp
          # luar-kak
        ];
        config = {
          ui = {
            statusLine = "top";
            enableMouse = true;
            assistant = "none";
          };
          numberLines.enable = true;
          numberLines.relative = true;
          numberLines.highlightCursor = true;
          # numberLines.separator = "  ";
          showMatching = true;
          indentWidth = 2;
          tabStop = 2;
          scrollOff.lines = 1;
          scrollOff.columns = 3;
          keyMappings = [
            {
              mode = "normal";
              key = "<esc>";
              effect = ";,";
              docstring =
                "Press escape to clear highlighted text and collapse cursors";
            }
            {
              mode = "normal";
              key = "<c-v>";
              effect = ":comment-line<ret>";
              docstring = "Comment a line with <c-v>!";
            }
            {
              mode = "normal";
              key = "b";
              effect = ":db<ret>";
              docstring = "close current buffer";
            }

            {
              mode = "normal";
              key = "n";
              effect = ":bp<ret>";
              docstring = "go to next buffer";
            }
            {
              mode = "normal";
              key = "m";
              effect = ":bn<ret>";
              docstring = "go to next buffer";
            }
          ];
        };
        extraConfig = "\n";
      };
    };

  };
}
