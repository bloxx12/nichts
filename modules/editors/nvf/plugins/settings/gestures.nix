{config, ...}: let
  inherit (config.modules.other.system) username;
in {
  programs.neovim-flake.settings.vim = {
    gestures.gesture-nvim.enable = false;
  };
}
