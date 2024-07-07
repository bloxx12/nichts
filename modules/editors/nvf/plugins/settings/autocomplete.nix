_:{
  programs.neovim-flake.settings.vim = {
    autocomplete = {
      enable = true;
      type = "nvim-cmp";
      mappings = {
        # close = "<C-e>";
       # confirm = "<tab>";
        next = "<C-n>";
        previous = "<C-p>";
        scrollDocsDown = "<C-j>";
        scrollDocsUp = "<C-k>";
      
      };
    };
  };
}
