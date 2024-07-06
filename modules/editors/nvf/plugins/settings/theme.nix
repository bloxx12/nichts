{config, ...}: let
  inherit (config.modules.other.system) username;
in {
  programs.neovim-flake.settings.vim = {
    theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
      transparent = true;
    };
  };
}
