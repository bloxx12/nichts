# Thank your Mr. poz! (https://git.jacekpoz.pl/jacekpoz/niksos)
{ config, inputs, lib, pkgs, ... }:
let
  cfg = config.modules.editors.neovim;
  inherit (config.modules.other.system) username;

  inherit (lib) mkEnableOption mkIf;
in {
  options.modules.editors.neovim.enable = mkEnableOption "neovim";

  config = mkIf cfg.enable {
    environment.sessionVariables = { EDITOR = "nvim"; };

    home-manager.users.${username} = {
      imports = [ inputs.neovim-flake.homeManagerModules.default ];

      programs.nvf = {
        enable = true;
        settings.vim = {
          package =
            inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
          viAlias = false;
          vimAlias = false;
          enableLuaLoader = true;
          scrollOffset = 7;
          preventJunkFiles = true;
          tabWidth = 4;
          autoIndent = false;
          cmdHeight = 1;
          useSystemClipboard = false;

          theme = {
            enable = true;
            name = "catppuccin";
            style = "mocha";
            transparent = true;
          };

          maps = {
            normal = {
              "<leader>v" = {
                action = "<CMD>Neotree toggle<CR>";
                silent = true;
              };
              "<leader>m" = {
                action = "<CMD>MarkdownPreviewToggle<CR>";
                silent = true;
              };
            };
            terminal = {
              # get out of terminal mode in toggleterm
              "<ESC>" = {
                action = "<C-\\><C-n>";
                silent = true;
              };
            };
          };

          statusline.lualine = {
            enable = true;
            theme = "catppuccin";
          };

          extraPlugins = with pkgs.vimPlugins; {
            zen-mode.package = zen-mode-nvim;
            unicode.package = unicode-vim;
          };

          treesitter = {
            enable = true;
            fold = true;
            context.enable = true;
          };

          autocomplete = {
            enable = true;
            alwaysComplete = false;
          };

          filetree.nvimTree = { enable = true; };

          terminal.toggleterm = {
            enable = true;
            setupOpts.direction = "tab";
            mappings.open = "<C-\\>";
            # TODO shading_factor
            # TODO shade_terminals
            # TODO size
          };

          git = {
            enable = true;
            gitsigns = {
              enable = true;
              # TODO enable / disable all the settings
            };
          };

          lsp = {
            enable = true;
            lspSignature.enable = true;
            lspconfig.enable = true;
            mappings = {
              addWorkspaceFolder = "<leader>wa";
              codeAction = "<leader>a";
              format = "<C-f>";
              goToDeclaration = "gD";
              goToDefinition = "gd";
              hover = "K";
              listImplementations = "gi";
              listReferences = "gr";
              listWorkspaceFolders = "<leader>wl";
              nextDiagnostic = "<leader>k";
              previousDiagnostic = "<leader>j";
              openDiagnosticFloat = "<leader>e";
              removeWorkspaceFolder = "<leader>wr";
              renameSymbol = "<leader>r";
              signatureHelp = "<C-k>";
            };
          };

          languages = {
            enableDAP = true;
            enableExtraDiagnostics = true;
            enableFormat = true;
            enableLSP = true;
            enableTreesitter = true;

            bash.enable = true;
            clang = {
              enable = true;
              cHeader = true;
            };
            css.enable = true;
            html.enable = true;
            java.enable = true;
            markdown.enable = true;
            nix.enable = true;
            ocaml.enable = true;
            rust = {
              enable = true;
              crates.enable = true;
            };
            ts.enable = true;
          };

          utility = {
            motion.leap.enable = true;
            preview.markdownPreview.enable = true;
            # TODO settings.theme = "dark";
            surround = {
              enable = true;
              useVendoredKeybindings = true;
            };
          };
          visuals.fidget-nvim.enable = true;

          # TODO laytan/cloak.nvim

          telescope.enable = true;

          comments.comment-nvim.enable = true;

          # TODO learn and add harpoon

          notes = {
            todo-comments = {
              enable = true;
              mappings.telescope = "<leader>tt";
              setupOpts.highlight.pattern = ".*<(KEYWORDS)s*";
            };
            orgmode = {
              enable = true;
              setupOpts = {
                org_agenda_files = [ "~/Notes/org" ];
                org_default_notes_file = "~/Notes/org/refile.org";
              };
              treesitter.enable = true;
            };
          };
        };
      };
    };
  };
}
