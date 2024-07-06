{config, ...}: let
  inherit (config.modules.other.system) username;
in {
  home-manager.${username}.programs.neovim-flake.settings.vim = {
    comments.comment-nvim.enable = true;
  };
}
