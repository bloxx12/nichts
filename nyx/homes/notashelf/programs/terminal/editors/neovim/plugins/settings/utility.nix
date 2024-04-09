{pkgs, ...}: {
  programs.neovim-flake.settings.vim = {
    utility = {
      ccc.enable = true;
      icon-picker.enable = true;
      diffview-nvim.enable = true;

      vim-wakatime = {
        enable = true;
        cli-package = pkgs.wakatime;
      };

      motion = {
        hop.enable = true;
        leap.enable = false;
      };

      preview = {
        glow.enable = true;
        markdownPreview.enable = true;
      };
    };
  };
}
