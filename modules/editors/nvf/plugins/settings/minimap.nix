{config, ...}: let
  inherit (config.modules.other.system) username;
in {
  programs.neovim-flake.settings.vim = {
    minimap = {
      # cool for vanity but practically useless on small screens
      minimap-vim.enable = false;
      codewindow.enable = false;
    };
  };
}
