{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.editors.kakoune;
  inherit (config.modules.other.system) username;
in {
  options.modules.editors.kakoune.enable = mkEnableOption "kakoune";

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.kakoune = {
        enable = true;
        plugins = with pkgs.kakounePlugins; [
          auto-pairs-kak
          fzf-kak
          powerline-kak
          byline-kak
          kakoune-lsp
        ];
        config = {
          ui = {
            statusLine = "top";
            enableMouse = true;
            assistant = "none";
          };
          scrollOff.lines = 1;
          scrollOff.columns = 3;
          keyMappings = [
            {
              mode = "normal";
              key = "<esc>";
              effect = ";,";
              docstring = "Press escape to clear highlighted text and collapse cursors";
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
            {
              mode = "normal";
              key = " f";
              effect = ":fzf-mode<ret>";
              docstring = "open fzf";
            }
          ];
        };
        extraConfig = ''
          # display line numbers
          add-highlighter global/ number-lines -hlcursor -relative -separator "  " -cursor-separator " |"
          # show matching symbols
          add-highlighter global/ show-matching
          # Intenting
          set-option global tabstop 4
          set-option global indentwidth 4
          # Scrolloff
          set-option global scrolloff 8,3
          # spellcheck (requires aspell)
          map -docstring "check document for spelling" global user w ": spell<ret>"
          map -docstring "clear document spelling" global user q ": spell-clear<ret>"
          plug "alexherbo2/auto-pairs.kak" config %{
            enable-auto-pairs
          }
          plug "andreyorst/fzf.kak" config %{
            require-module fzf
            require-module fzf-grep
            require-module fzf-file
          } defer fzf %{
            set-option global fzf_highlight_command "lat -r {}"
          } defer fzf-file %{
            set-option global fzf_file_command "fd . --no-ignore-vcs"
          } defer fzf-grep %{
            set-option global fzf_grep_command "fd"
          }
          plug "andreyorst/powerline.kak" defer kakoune-themes %{
            powerline-theme pastel
          } defer powerline %{
            powerline-format global "git lsp bufname filetype mode_info lsp line_column position"
            set-option global powerline_separator_thin ""
            set-option global powerline_separator ""
          } config %{
            powerline-start
          }
          plug "evanrelf/byline.kak" config %{
            require-module "byline"
          }
        '';
      };
    };
  };
}
