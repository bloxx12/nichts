{config, ...}: let
  inherit (config.modules.other.system) username;
in {
  home-manager.${username}.
  programs.neovim-flake.settings.vim = {
    statusline = {
      lualine = {
        enable = true;
        theme = "catppuccin";
      };
    };
  };
}
