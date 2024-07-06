{config, ...}: let
  inherit (config.modules.other.system) username;
in {
  programs.neovim-flake.settings.vim = {
    debugger.nvim-dap = {
      enable = true;
      ui.enable = true;
    };
  };
}
