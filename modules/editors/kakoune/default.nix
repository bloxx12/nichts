{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.modules.other.system) username;
  cfg = config.modules.system.programs.editors.kakoune;
  inherit (lib) mkIf mkEnableOption;
in {
  imports = [./mappings.nix];
  options.modules.editors.kakoune.enable = mkEnableOption "kakoune";
  config.home-manager.users.${username}.programs.kakoune = mkIf cfg.enable {
    enable = true;
    package = pkgs.kakoune-unwrapped;
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
      active-window-kak
      auto-pairs-kak
      byline-kak # ope
      prelude-kak # dependency of byline
      fzf-kak
      kakboard
      kakoune-buffer-switcher
      kakoune-buffers
      kakoune-lsp
      kakoune-rainbow
      kakoune-registers
      kakoune-vertical-selection
      powerline-kak
      quickscope-kak
      smarttab-kak
      zig-kak
    ];
    # extraConfig = ./kakrc;
  };
}
