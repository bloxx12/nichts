_: {
  programs.neovim-flake.settings.vim = {
    terminal = {
      toggleterm = {
        enable = true;
        mappings.open = "<C-t>";
        lazygit = {
          enable = true;
          direction = "tab";
        };
        setupOpts = {
          direction = "tab";
        };
      };
    };
  };
}
