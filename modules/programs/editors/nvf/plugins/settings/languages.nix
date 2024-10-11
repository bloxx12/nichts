_: {
  programs.neovim-flake.settings.vim = {
    languages = {
      enableLSP = true;
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;

      markdown.enable = true;
      html.enable = true;
      java.enable = true;
      css.enable = true;
      # tailwind.enable = false;
      # ts.enable = true;
      # go.enable = true;
      # python.enable = true;
      bash.enable = true;
      typst.enable = true;
      zig.enable = true;
      # dart.enable = false;
      # elixir.enable = false;
      # svelte.enable = false;
      # sql.enable = false;
      lua = {
        enable = true;
        lsp.neodev.enable = true;
      };

      nix = {
        enable = true;
        lsp.enable = true;
      };
      rust = {
        enable = true;
        crates.enable = true;
      };

      clang = {
        enable = true;
        lsp = {
          enable = true;
          server = "clangd";
        };
      };
    };
  };
}
