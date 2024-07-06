{config, ...}: let
  inherit (config.modules.other.system) username;
in {
  home-manager.${username}.
  programs.neovim-flake.settings.vim = {
    notes = {
      todo-comments.enable = true;
      mind-nvim.enable = false;
      obsidian.enable = false;
    };
  };
}
