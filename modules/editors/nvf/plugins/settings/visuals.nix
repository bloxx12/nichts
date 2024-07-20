_: {
  programs.neovim-flake.settings.vim = {
    visuals = {
      enable = true;
      nvimWebDevicons.enable = true;
      scrollBar.enable = false;
      smoothScroll.enable = false;
      cellularAutomaton.enable = true;
      highlight-undo.enable = true;

      indentBlankline.enable = true;

      cursorline = {
        enable = true;
        lineTimeout = 0;
      };

      fidget-nvim = {
        enable = true;
        setupOpts = {
          notification.window = {
            winblend = 0;
            border = "none";
          };
        };
      };
    };
  };
}
