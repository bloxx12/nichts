{config, ...}: let
  inherit (config.modules.other.system) username;
in {
  home-manager.${username}.
  programs.neovim-flake.settings.vim = {
    tabline = {
      nvimBufferline.enable = true;
    };
  };
}
