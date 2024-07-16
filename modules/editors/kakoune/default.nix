{
  config,
  lib,
  pkgs,
}: let
  inherit (config.modules.other.system) username;
  cfg = config.modules.editors.kakoune;
  inherit (lib) mkIf mkEnableOption;
in {
  options.modules.editors.kakoune.enable = mkEnableOption "kakoune";
  config.home-manager.users.${username}.programs.kakoune = mkIf cfg.enable {
    enable = true;
    config = {
      autoComplete = true;
      autoReload = true;
      indentWidth = 4;
      tabStop = 4;
      incrementalSearch = false;
      numberLines = {
        enable = true;
        relative = true;
        highlightCursor = true;
        separator = "|";
      };

      scrollOff = {
        lines = 4;
        columns = 4;
      };
      ui = {
        enableMouse = true;
        assistant = "none";
        statusLine = "bottom";
        wrapLines = {
          enable = true;
          indent = true;
          word = true;
        };
      };
      plugins = with pkgs.kakounePlugins; [
        auto-pairs-kak
        fzf-kak
        powerline-kak
        byline-kak
        kakoune-lsp
      ];
    };
  };
}

