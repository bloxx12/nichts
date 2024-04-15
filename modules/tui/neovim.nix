{ config, inputs, lib, pkgs, ... }:
with lib; let
    cfg = config.modules.programs.neovim;
    username = config.modules.other.system.username;
in {
    options.modules.programs.neovim.enable = mkEnableOption "neovim";

    config = mkIf cfg.enable {
        home-manager.users.${username} = {
            imports = [ inputs.nixvim.homeManagerModules.nixvim ];
            programs.nixvim = {
                enable = true;
                enableMan = true;
                defaultEditor = true;

                opts = {
                    background = "dark";
                    shiftwidth = 4;
                    autoread = true;
                    cmdheight = 1;
                    encoding = "utf8";
                    expandtab = true;
                    hidden = true;
                    ignorecase = true;
                    linebreak = true;
                    mousemoveevent = true;
                    number = true;
                    relativenumber = true;
                    showmatch = true;
                    smartcase = true;
                    smartindent = true;
                    smarttab = true;
                    so = 7;
                    timeoutlen = 500;
                    tabstop = 4;
                    updatetime = 50;
                };

                globals.mapleader = " ";

                plugins = {
                    lualine = {
                        enable = true;
                        theme = "catppuccin";
                    };
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
                   # TODO laytan/cloak.nvim
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
                            rnix-lsp.enable = true;
			                pyright.enable = true;
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
                    lazygit-nvim
                ];

		keymaps = [
		    {
		        mode = "n";
			    key = "<leader>pv";
    			action = "<cmd>Explore<CR>";
		    }
            {
                mode = "n";
                key = "<leader>w";
                action = "<cmd>w<CR>";
            }
            {
                mode = "n";
                key = "<leader>qw";
                action = "<cmd>q<CR>";
            }
            {
                mode = "n";
                key = "<leader>gg";
                action = "<cmd>LazyGit<CR>";
            }
		];
            };
        };
    };
}
