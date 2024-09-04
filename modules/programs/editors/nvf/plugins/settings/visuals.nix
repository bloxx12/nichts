_: {
  programs.neovim-flake.settings.vim = {
    visuals = {
      enable = true;
      nvimWebDevicons.enable = true;

      indentBlankline.enable = true;

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
