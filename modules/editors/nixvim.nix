{ config, lib, ... }:
let cfg = config.modules.editors.nixvim;
in {
  options.modules.editors.nixvim.enable = lib.mkEnableOption "nixvim";

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      colorschemes.gruvbox.enable = true;
      options = {
        number = true;
        relativenumber = true;
        shiftwidth = 2;
        scrolloff = 8;
      };
      plugins = {
        lightline.enable = true;
        lsp = {
          enable = true;
          servers = {
            nixd.enable = true;
            lua-ls.enable = true;
          };
        };
        cmp = {
          enable = true;
          settings = {
            sources = [ { name = "nvim_lsp"; } { name = "buffer"; } { name = "path"; } ];
            mapping = {
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<Tab>" = {
          action = ''
            function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expandable() then
                luasnip.expand()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              elseif check_backspace() then
                fallback()
              else
                fallback()
              end
            end
          '';
          modes = [ "i" "s" ];
        };
      };
          };
        };
        telescope = {
          enable = true;
          extensions = {
            fzf-native = {
              enable = true;
              settings = {
                fuzzy = true;
                override_file_sorter = true;
                override_generic_sorter = true;
                case_mode = "smart_case";
              };
            };
          };
        };
        treesitter.enable = true;
        treesitter-context.enable = true;
        comment.enable = true;
        gitblame.enable = true;
        trouble.enable = true;
        todo-comments.enable = true;
        fugitive.enable = true;
        nvim-autopairs.enable = true;
        diffview.enable = true;
        oil.enable = true;
        undotree.enable = true;
        fzf-lua.enable = true;
        surround.enable = true;
        lazygit.enable = true;
        # Theming 
        gitsigns.enable = true;
        #	barbar.enable = true;
        lualine = {
          enable = true;
          #theme = "palenight";
        };
        nix.enable = true;
        zig.enable = true;

      };
    };
  };
}
