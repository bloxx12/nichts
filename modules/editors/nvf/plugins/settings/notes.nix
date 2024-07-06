{config, ...}: let
  inherit (config.modules.other.system) username;
in {
  programs.neovim-flake.settings.vim = {
    notes = {
      todo-comments.enable = true;
      mind-nvim.enable = false;
      obsidian.enable = false;
    };
  };
}
