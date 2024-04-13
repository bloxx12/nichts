{
    config,
    inputs,
    lib,
    pkgs,
    ...
}: with lib; let
    cfg = config.modules.programs.neovim;
    username = config.modules.other.system.username;
in {
    options.modules.programs.neovim.enable = mkEnableOption "neovim";

    config = mkIf cfg.enable {
        nixpkgs.overlays = [ inputs.neovim-nightly-overlay.overlay ];

        home-manager.users.${username} = {
            imports = [ inputs.nixvim.homeManagerModules.nixvim ];

            programs.nixvim = {
                enable = true;
                package = pkgs.neovim-nightly;
                enableMan = true;
                defaultEditor = true;

                colorscheme = "catppuccin";
                colorschemes.catppuccin = {
                    enable = true;
                    flavour = "mocha";
                    transparentBackground = true;
                };

                opts = {
                    number = true;
                    relativenumber = true;
                    autoread = true;
                    so = 7;
                    cmdheight = 1;
                    ignorecase = true;
                    smartcase = true;
                    showmatch = true;
                    timeoutlen = 500;
                    encoding = "utf8";
                    smarttab = true;
                    shiftwidth = 4;
                    tabstop = 4;
                    expandtab = true;
                    linebreak = true;
                    smartindent = true;
                    updatetime = 300;
                    hidden = true;
                    background = "dark";
                    mousemoveevent = true;
                    smoothscroll = true;
                };

                globals = {
                    mapleader = " ";
                };

                keymaps = [
                    {
                        # TODO move this to lua to be cool
                        # action = "vim.cmd { cmd = \"Neotree\", args = { \"toggle\" } }";
                        # lua = true;
                        action = "<CMD>Neotree toggle<CR>";
                        key = "<leader>v";
                        options.silent = true;
                    }
                    {
                        action = "vim.cmd.MarkdownPreviewToggle";
                        lua = true;
                        key = "<leader>m";
                        options.silent = true;
                    }
                ];

                plugins = {
                    airline = {
                        enable = false;
                        settings.theme = "catppuccin";
                    };
                    lualine = {
                        enable = true;
                        theme = "catppuccin";
                    };
                    fugitive.enable = true;
                    treesitter = {
                        enable = true;
                        folding = false;
                        indent = true;
                        nixvimInjections = true;
                        incrementalSelection.enable = true;
                    };
                    treesitter-context = {
                        enable = true;
                    };
                    coq-nvim = {
                        enable = true;
                        installArtifacts = true;
                        settings = {
                            auto_start = "shut-up";
                            keymap.recommended = true;
                            completion.always = false;
                        };
                    };
                    neo-tree = {
                        enable = true;
                    };
                    toggleterm = {
                        enable = true;
                        direction = "float";
                        openMapping = "<C-\\>";
                        shadeTerminals = true;
                        shadingFactor = 2;
                        size = 10;
                    };
                    # TODO laytan/cloak.nvim
                    gitsigns = {
                        enable = true;
                        settings = {
                            current_line_blame = true;
                            numhl = true;
                            signcolumn = true;
                            word_diff = true;
                            on_attach = ''
                                function(bufnr)
                                    local gs = package.loaded.gitsigns

                                    local function map(mode, l, r, opts)
                                      opts = opts or {}
                                      opts.buffer = bufnr
                                      vim.keymap.set(mode, l, r, opts)
                                    end

                                    -- Navigation
                                    map('n', ']c', function()
                                      if vim.wo.diff then return ']c' end
                                      vim.schedule(function() gs.next_hunk() end)
                                      return '<Ignore>'
                                    end, {expr=true})

                                    map('n', '[c', function()
                                      if vim.wo.diff then return '[c' end
                                      vim.schedule(function() gs.prev_hunk() end)
                                      return '<Ignore>'
                                    end, {expr=true})

                                    -- Actions
                                    map('n', '<leader>hs', gs.stage_hunk)
                                    map('n', '<leader>hr', gs.reset_hunk)
                                    map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
                                    map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
                                    map('n', '<leader>hS', gs.stage_buffer)
                                    map('n', '<leader>hu', gs.undo_stage_hunk)
                                    map('n', '<leader>hR', gs.reset_buffer)
                                    map('n', '<leader>hp', gs.preview_hunk)
                                    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
                                    map('n', '<leader>tb', gs.toggle_current_line_blame)
                                    map('n', '<leader>hd', gs.diffthis)
                                    map('n', '<leader>hD', function() gs.diffthis('~') end)
                                    map('n', '<leader>td', gs.toggle_deleted)

                                    -- Text object
                                    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
                                  end
                            '';
                        };
                    };
                    lsp = {
                        enable = true;
                        servers = {
                            rust-analyzer = {
                                enable = true;
                                installCargo = false;
                                installRustc = false;
                            };
                            lua-ls.enable = true;
                            ccls.enable = true;
                            nil_ls.enable = true;
                            bashls.enable = true;
                            tsserver.enable = true;
                            java-language-server.enable = true;
                            #pylyzer.enable = true;
                        };
                        #onAttach = ''
                        #    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

                        #    local bufopts = { noremap = true, silent = true, buffer = bufnr }
                        #    vim.keymap.set('n', '<space>wl', function()
                        #        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                        #    end, bufopts)
                        #    vim.keymap.set('n', '<C-f>', function() vim.lsp.buf.format { async = true } end, bufopts)
                        #'';
                        keymaps = {
                            lspBuf = {
                                gD = "declaration";
                                gd = "definition";
                                K = "hover";
                                gi = "implementation";
                                "<C-k>" = "signature_help";
                                "<leader>wa" = "add_workspace_folder";
                                "<leader>wr" = "remove_workspace_folder";
                                "<leader>wl" = "list_workspace_folders";
                                "<leader>D" = "type_definition";
                                "<leader>r" = "rename";
                                "<leader>a" = "code_action";
                                gr = "references";
                                "<C-f>" = "format";
                            };
                            diagnostic = {
                                "<leader>e" = "open_float";
                                "<leader>j" = "goto_prev";
                                "<leader>k" = "goto_next";
                                "<leader>q" = "setloclist";
                            };
                            silent = true;
                        };
                    };
                    rust-tools = {
                        enable = true;
                        crateGraph = {
                            enabledGraphvizBackends = ["png" "svg"];
                            backend = "x11";
                        };
                        inlayHints = {
                            auto = true;
                            onlyCurrentLine = true;
                            showParameterHints = true;
                        };
                    };
                    leap.enable = true;
                    fidget.enable = true;
                    telescope = {
                        enable = true;
                        keymaps = {
                            "<leader>ff" = "find_files";
                            "<leader>fg" = "git_files";
                            "<leader>fs" = "live_grep";
                            "<leader>fb" = "buffers";
                            "<leader>fh" = "help_tags";
                        };
                        keymapsSilent = true;
                    };
                    comment.enable = true;
                    crates-nvim.enable = true;
                    harpoon = {
                        enable = true;
                        package = pkgs.vimPlugins.harpoon.overrideAttrs {
                            src = pkgs.fetchFromGitHub {
                                owner = "ThePrimeagen";
                                repo = "harpoon";
                                rev = "a38be6e0dd4c6db66997deab71fc4453ace97f9c";
                                hash = "sha256-RjwNUuKQpLkRBX3F9o25Vqvpu3Ah1TCFQ5Dk4jXhsbI=";
                            };
                        };
                        enableTelescope = true;
                        keymapsSilent = false;
                    };
                    markdown-preview = {
                        enable = true;
                        settings.theme = "dark";
                    };
                };

                extraPlugins = with pkgs.vimPlugins; [
                    zen-mode-nvim
                ];
            };
        };
    };
}
