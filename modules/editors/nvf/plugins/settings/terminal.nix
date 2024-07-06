{config, ...}: let
  inherit (config.modules.other.system) username;
in {
  home-manager.${username}.
  programs.neovim-flake.settings.vim = {
    terminal = {
      toggleterm = {
        enable = true;
        mappings.open = "<C-t>";

        setupOpts = {
          direction = "tab";
          lazygit = {
            enable = true;
            direction = "tab";
          };
        };
      };
    };
  };
}
