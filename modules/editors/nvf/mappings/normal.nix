{
  programs.neovim-flake.settings.vim.maps = {
    normal = {
      #      "<leader>gg".action = "<cmd>LazyGit<CR>";
      # General
      "<leader>fd".action = "<cmd>lua vim.g.formatsave = not vim.g.formatsave<CR>";
      "<leader>zt".action = ":<C-U>let g:default_terminal = v:count1<CR>";
      # "<leader>ld".action = ":lua vim.diagnostic.setqflist({open = true})<CR>";
      # "<leader>lf".action = ":lua vim.lsp.buf.format()<CR>";
      # "<leader>li".action = ":lua vim.lsp.buf.implementation()<CR>";
      "<leader>;".action = "A;<esc>"; # Append #

      # Diffview
      "<leader>gdq".action = "<cmd>DiffviewClose<CR>";
      "<leader>gdd".action = "<cmd>DiffviewOpen ";
      "<leader>gdm".action = "<cmd>DiffviewOpen<CR>";
      "<leader>gdh".action = "<cmd>DiffviewFileHistory %<CR>";
      "<leader>gde".action = "<cmd>DiffviewToggleFiles<CR>";

      # Git
      "<leader>gu".action = "<cmd>Gitsigns undo_stage_hunk<CR>";
      "<leader>g<C-w>".action = "<cmd>Gitsigns preview_hunk<CR>";
      "<leader>gp".action = "<cmd>Gitsigns prev_hunk<CR>";
      "<leader>gn".action = "<cmd>Gitsigns next_hunk<CR>";
      "<leader>gP".action = "<cmd>Gitsigns preview_hunk_inline<CR>";
      "<leader>gR".action = "<cmd>Gitsigns reset_buffer<CR>";
      "<leader>gb".action = "<cmd>Gitsigns blame_line<CR>";
      "<leader>gD".action = "<cmd>Gitsigns diffthis HEAD<CR>";
      "<leader>gw".action = "<cmd>Gitsigns toggle_word_diff<CR>";
      # Movement
      "<C-h>".action = "<C-W>h";
      "<C-j>".action = "<C-W>j";
      "<C-k>".action = "<C-W>k";
      "<C-l>".action = "<C-W>l";
      # Telescope
      "<M-f>".action = "<cmd>Telescope resume<CR>";
      "<leader>fq".action = "<cmd>Telescope quickfix<CR>";
      "<leader>f/".action = "<cmd>Telescope live_grep<cr>";
    };

    normalVisualOp = {
      "<leader>gs".action = "<cmd>Gitsigns stage_hunk<CR>";
      "<leader>gr".action = "<cmd>Gitsigns reset_hunk<CR>";
      "<leader>lr".action = "<cmd>lua vim.lsp.buf.references()<CR>";

      # ssr.nvim
      "<leader>sr".action = ":lua require('ssr').open()<CR>";

      # Toggleterm
      "<leader>ct" = {
        # action = ":<C-U>ToggleTermSendVisualLines v:count<CR>";
        action = "':ToggleTermSendVisualLines ' . v:count == 0 ? g:default_terminal : v:count";
        expr = true;
      };
    };
  };
}
