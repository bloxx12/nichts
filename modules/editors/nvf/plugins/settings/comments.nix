{config, ...}: let
  inherit (config.modules.other.system) username;
in {
  programs.neovim-flake.settings.vim = {
    comments.comment-nvim.enable = true;
  };
}
