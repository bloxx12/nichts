{config, ...}: let
  inherit (config.modules.other.system) username;
in {
  programs.neovim-flake.settings.vim = {
    binds = {
      whichKey.enable = true;
      cheatsheet.enable = false;
    };
  };
}
