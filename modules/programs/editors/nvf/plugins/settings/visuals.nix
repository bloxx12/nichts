_: {
  programs.neovim-flake.settings.vim = {
    visuals = {
      enable = true;
      nvimWebDevicons.enable = true;
      cellularAutomaton.enable = true;
      highlight-undo.enable = true;

      indentBlankline.enable = true;

      cursorline = {
        enable = false;
        lineTimeout = 0;
      };

      fidget-nvim = {
        enable = true;
        setupOpts = {
          notification.window = {
            winblend = 0;
            border = "none";
            render_limit = 7;
          };
        };
      };
    };
  };
}
