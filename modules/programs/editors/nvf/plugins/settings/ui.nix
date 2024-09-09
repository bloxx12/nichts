_: {
  programs.neovim-flake.settings.vim = {
    ui = {
      noice.enable = true;
      colorizer.enable = true;
      modes-nvim.enable = false;
      illuminate.enable = true;

      breadcrumbs = {
        enable = false;
        source = "nvim-navic";
        navbuddy.enable = false;
      };

      smartcolumn = {
        enable = false;
        setupOpts = {
          columnAt.languages = {
            markdown = [80];
            nix = [120];
            ruby = 110;
            java = 120;
            go = [130];
          };
        };
      };

      borders = {
        enable = true;
        globalStyle = "rounded";
      };
    };
  };
}
