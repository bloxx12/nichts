{
  config,
  pkgs,
  ...
}: let
  inherit (config.modules.other.system) username;
  inherit (pkgs.vimPlugins) friendly-snippets aerial-nvim nvim-surround undotree mkdir-nvim ssr-nvim direnv-vim legendary-nvim lazygit-nvim;
  inherit (pkgs) fetchFromGitHub;
  inherit (pkgs.vimUtils) buildVimPlugin;

  pluginSources = {
    smart-splits = buildVimPlugin {
      name = "smart-splits";
      src = fetchFromGitHub {
        owner = "mrjones2014";
        repo = "smart-splits.nvim";
        rev = "95833675cd92538bf9cded1d2d58d1fc271c5428";
        hash = "sha256-TsEzHalLTLp9USV0aGRadAObViC/OpIJeuEJ95lJUL8=";
      };
    };

    regexplainer = buildVimPlugin {
      name = "nvim-regexplainer";
      src = fetchFromGitHub {
        owner = "bennypowers";
        repo = "nvim-regexplainer";
        rev = "4250c8f3c1307876384e70eeedde5149249e154f";
        hash = "sha256-15DLbKtOgUPq4DcF71jFYu31faDn52k3P1x47GL3+b0=";
      };
    };

    specs-nvim = buildVimPlugin {
      name = "specs.nvim";
      src = fetchFromGitHub {
        owner = "notashelf";
        repo = "specs.nvim";
        rev = "0792aaebf8cbac0c8545c43ad648b98deb83af42";
        hash = "sha256-doHE/3bRuC8lyYxMk927JmwLfiy7aR22+i+BNefEGJ4=";
      };
    };

    deferred-clipboard = buildVimPlugin {
      name = "deferred-clipboard";
      src = fetchFromGitHub {
        owner = "EtiamNullam";
        repo = "deferred-clipboard.nvim";
        rev = "810a29d166eaa41afc220cc7cd85eeaa3c43b37f";
        hash = "sha256-nanNQEtpjv0YKEkkrPmq/5FPxq+Yj/19cs0Gf7YgKjU=";
      };
    };
    /*
    data-viewer-nvim = buildVimPlugin {
      name = "data-viewer.nvim";
      src = fetchFromGitHub {
        owner = "VidocqH";
        repo = "data-viewer.nvim";
        rev = "40ddf37bb7ab6c04ff9e820812d1539afe691668";
        hash = "sha256-D5hvLhsYski11H9qiDDL2zlZMtYmbpHgpewiWR6C7rE=";
      };
    };
    */
    vim-nftables = buildVimPlugin {
      name = "vim-nftables";
      src = fetchFromGitHub {
        owner = "awisse";
        repo = "vim-nftables";
        rev = "bc29309080b4c7e1888ffb1a830846be16e5b8e7";
        hash = "sha256-L1x3Hv95t/DBBrLtPBKrqaTbIPor/NhVuEHVIYo/OaA=";
      };
    };

    neotab-nvim = buildVimPlugin {
      name = "neotab.nvim";
      src = fetchFromGitHub {
        owner = "kawre";
        repo = "neotab.nvim";
        rev = "6c6107dddaa051504e433608f59eca606138269b";
        hash = "sha256-bSFKbjj8fJHdfBzYoQ9l3NU0GAYfdfCbESKbwdbLNSw=";
      };
    };
  };
in {
  programs.neovim-flake.settings.vim.extraPlugins = {
    # plugins that are pulled from nixpkgs
    # direnv = {package = direnv-vim;};
    friendly-snippets = {package = friendly-snippets;};
    mkdir-nvim = {package = mkdir-nvim;};
    lazygit-nvim = {package = lazygit-nvim;};
    aerial = {
      package = aerial-nvim;
      setup = "require('aerial').setup {}";
    };

    nvim-surround = {
      package = nvim-surround;
      setup = "require('nvim-surround').setup {}";
    };
    /*
    undotree = {
      package = undotree;
      setup = ''
        vim.g.undotree_ShortIndicators = true
        vim.g.undotree_TreeVertShape = '│'
      '';
    };
    */
    ssr-nvim = {
      package = ssr-nvim;
      setup = "require('ssr').setup {}";
    };

    legendary = {
      package = legendary-nvim;
      setup = ''
        require('legendary').setup {};
      '';
    };

    # plugins that are built from their sources
    #    regexplainer = {package = pluginSources.regexplainer;};
    #    vim-nftables = {package = pluginSources.vim-nftables;};
    /*
    data-view = {
      package = pluginSources.data-viewer-nvim;
      setup = ''
        -- open data files in data-viewer.nvim
        vim.api.nvim_exec([[
          autocmd BufReadPost,BufNewFile *.sqlite,*.csv,*.tsv DataViewer
        ]], false)


        -- keybinds
        vim.api.nvim_set_keymap('n', '<leader>dv', ':DataViewer<CR>', {noremap = true})
        vim.api.nvim_set_keymap('n', '<leader>dvn', ':DataViewerNextTable<CR>', {noremap = true})
        vim.api.nvim_set_keymap('n', '<leader>dvp', ':DataViewerPrevTable<CR>', {noremap = true})
        vim.api.nvim_set_keymap('n', '<leader>dvc', ':DataViewerClose<CR>', {noremap = true})
      '';
    };
    */
    smart-splits = {
      package = pluginSources.smart-splits;
      setup = "require('smart-splits').setup {}";
    };
    /*
    neotab-nvim = {
      package = pluginSources.neotab-nvim;
      setup = ''
        require('neotab').setup {
          tabkey = "<Tab>",
          act_as_tab = true,
          behavior = "nested", ---@type ntab.behavior
          pairs = { ---@type ntab.pair[]
              { open = "(", close = ")" },
              { open = "[", close = "]" },
              { open = "{", close = "}" },
              { open = "'", close = "'" },
              { open = '"', close = '"' },
              { open = "`", close = "`" },
              { open = "<", close = ">" },
          },
          exclude = {},
          smart_punctuators = {
            enabled = false,
            semicolon = {
                enabled = false,
                ft = { "cs", "c", "cpp", "java" },
            },
            escape = {
                enabled = false,
                triggers = {}, ---@type table<string, ntab.trigger>
            },
          },
        }
      '';
    };
    */
    specs-nvim = {
      package = pluginSources.specs-nvim;
      setup = ''
        require('specs').setup {
          show_jumps = true,
          popup = {
            delay_ms = 0,
            inc_ms = 15,
            blend = 15,
            width = 10,
            winhl = "PMenu",
            fader = require('specs').linear_fader,
            resizer = require('specs').shrink_resizer
          },

          ignore_filetypes = {'NvimTree', 'undotree'},

          ignore_buftypes = {nofile = true},
        }

        -- toggle specs using the <C-b> keybind
        vim.api.nvim_set_keymap('n', '<C-b>', ':lua require("specs").show_specs()', { noremap = true, silent = true })

        -- bind specs to navigation keys
        vim.api.nvim_set_keymap('n', 'n', 'n:lua require("specs").show_specs()<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', 'N', 'N:lua require("specs").show_specs()<CR>', { noremap = true, silent = true })
      '';
    };
  };
}
