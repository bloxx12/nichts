{config, ...}: let
  inherit (config.modules.other.system) username;
in {
  programs.neovim-flake.settings.vim = {
    dashboard = {
      alpha.enable = false;
    };
  };
}
