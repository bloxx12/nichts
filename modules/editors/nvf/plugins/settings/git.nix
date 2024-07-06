{config, ...}: let
  inherit (config.modules.other.system) username;
in {
  programs.neovim-flake.settings.vim = {
    git = {
      enable = true;
      vim-fugitive.enable = true;
      gitsigns = {
        enable = true;
        codeActions.enable = false; # no.
      };
    };
  };
}
