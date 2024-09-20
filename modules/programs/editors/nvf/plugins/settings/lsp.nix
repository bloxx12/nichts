_: {
  programs.neovim-flake.settings.vim = {
    lsp = {
      formatOnSave = true;
      lspkind.enable = true;
      lsplines.enable = true;
      lightbulb.enable = false;
      lspsaga.enable = false;
      lspSignature.enable = true;
      # nvimCodeActionMenu.enable = true;
      #     trouble.enable = false;
      #     nvim-docs-view.enable = true;
    };
  };
}
