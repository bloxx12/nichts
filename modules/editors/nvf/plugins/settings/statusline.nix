{config, ...}: let
  inherit (config.modules.other.system) username;
in {
  programs.neovim-flake.settings.vim = {
    statusline = {
      lualine = {
        enable = true;
        theme = "catppuccin";
      };
    };
  };
}
