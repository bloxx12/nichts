{config, ...}: let
  inherit (config.modules.other.system) username;
in {
  home-manager.${username}.programs.neovim-flake.settings.vim = {
    binds = {
      whichKey.enable = true;
      cheatsheet.enable = false;
    };
  };
}
