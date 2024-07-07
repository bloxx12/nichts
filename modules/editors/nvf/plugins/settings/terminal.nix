_: {
  programs.neovim-flake.settings.vim = {
    terminal = {
      toggleterm = {
        enable = false;
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
