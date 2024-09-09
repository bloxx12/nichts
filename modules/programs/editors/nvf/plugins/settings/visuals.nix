_: {
  programs.neovim-flake.settings.vim = {
    visuals = {
      enable = true;
      nvimWebDevicons.enable = true;

      indentBlankline.enable = false;

      fidget-nvim = {
        enable = false;
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
