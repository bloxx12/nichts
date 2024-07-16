{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.modules.other.system) username;
  cfg = config.modules.editors.kakoune;
  inherit (lib) mkIf mkEnableOption;
in {
  imports = [./mappings.nix];
  options.modules.editors.kakoune.enable = mkEnableOption "kakoune";
  config.home-manager.users.${username}.programs.kakoune = mkIf cfg.enable {
    enable = true;
    config = {
      autoComplete = ["insert"];
      autoReload = "yes";
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
      wrapLines = {
        enable = true;
        indent = true;
        word = true;
      };

      ui = {
        enableMouse = true;
        assistant = "none";
        statusLine = "bottom";
      };
    };
    plugins = with pkgs.kakounePlugins; [
      auto-pairs-kak
      fzf-kak
      powerline-kak
      byline-kak
      kakoune-lsp
    ];
    # extraConfig = ./kakrc;
  };
}

