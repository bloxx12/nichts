_: {
  programs.neovim-flake.settings.vim = {
    tabline = {
      nvimBufferline = {
        enable = true;
        setupOpts = {
          style_preset = "minimal";
          themable = true;
        };
      };
    };
  };
}
