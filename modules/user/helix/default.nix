{
  symlinkJoin,
  makeWrapper,
  helix,
  gdb,
  black,
  cmake-format,
  tinymist,
  lib,
  marksman,
  lldb_19,
  stdenv,
  shellcheck,
  formats,
  lazygit,
  deno,
  shfmt,
  bash-language-server,
  clang-tools,
  cmake-language-server,
  dprint,
  nil,
  alejandra,
  pyright,
  typescript-language-server,
  ...
}: let
  inherit (lib) getExe;
  toml = formats.toml {};
  helix-config = {
    theme = "catppuccin_mocha";
    editor = {
      cursorline = false;
      color-modes = true;
      indent-guides.render = true;
      lsp = {
        display-inlay-hints = true;
        display-messages = true;
      };
      line-number = "relative";
      true-color = true;
      auto-format = true;
      completion-timeout = 5;
      mouse = true;
      bufferline = "multiple";
      soft-wrap.enable = true;
      cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };
      statusline = {
        left = ["spinner" "version-control" "diagnostics" "file-name"];
        right = ["file-base-name" "file-type" "position" "file-encoding"];
      };
      gutters.layout = ["diff" "diagnostics" "line-numbers" "spacer"];
      inline-diagnostics = {
        cursor-line = "hint";
        other-lines = "error";
      };
    };
    keys = {
      normal = {
        space.g = [":new" ":insert-output XDG_CONFIG_HOME=~/.config ${getExe lazygit}" ":buffer-close!" ":redraw"];
        esc = ["collapse_selection" "keep_primary_selection" "normal_mode"];
        A-H = "goto_previous_buffer";
        A-L = "goto_next_buffer";
        A-w = ":buffer-close";
        A-f = ":format";
        A-r = ":reload";
        A-x = "extend_to_line_bounds";
        X = ["extend_line_up" "extend_to_line_bounds"];
      };
      select = {
        A-x = "extend_to_line_bounds";
        X = ["extend_line_up" "extend_to_line_bounds"];
      };
    };
  };
  helix-languages = {
    language = let
      extraFormatter = lang: {
        command = getExe deno;
        args = ["fmt" "-" "--ext" lang];
      };
    in [
      {
        name = "bash";
        auto-format = true;
        formatter = {
          command = getExe shfmt;
          args = ["-i" "2"];
        };
      }
      {
        name = "clojure";
        injection-regex = "(clojure|clj|edn|boot|yuck)";
        file-types = ["clj" "cljs" "cljc" "clje" "cljr" "cljx" "edn" "boot" "yuck"];
      }
      {
        name = "cmake";
        auto-format = true;
        language-servers = ["cmake-language-server"];
        formatter = {
          command = getExe cmake-format;
          args = ["-"];
        };
      }
      {
        name = "javascript";
        auto-format = true;
        language-servers = ["dprint" "typescript-language-server"];
      }
      {
        name = "json";
        formatter = extraFormatter "json";
      }
      {
        name = "markdown";
        auto-format = true;
        formatter = extraFormatter "md";
      }
      {
        name = "python";
        language-servers = ["pyright"];
        formatter = {
          command = getExe black;
          args = ["-" "--quiet" "--line-length 100"];
        };
      }
      {
        name = "typescript";
        auto-format = true;
        language-servers = ["dprint" "typescript-language-server"];
      }
      {
        name = "rust";
        debugger = {
          command = "${lldb_19}/bin/lldb-dap";
          name = "lldb";
          transport = "stdio";
          templates = [
            {
              name = "binary";
              request = "launch";
              completion = [
                {
                  name = "binary";
                  completion = "filename";
                }
              ];
              args = {
                program = "{0}";
                runInTerminal = true;
              };
            }
          ];
        };
      }
      {
        name = "c";
        debugger = {
          name = "gdb";
          command = getExe gdb;
          transport = "stdio";
          templates = [
            {
              name = "binary";
              request = "launch";
              completion = [
                {
                  name = "binary";
                  completion = "filename";
                }
              ];
              args = {
                program = "{0}";
                runInTerminal = true;
              };
            }
          ];
        };
      }
    ];

    language-server = {
      bash-language-server = {
        command = getExe bash-language-server;
        args = ["start"];
      };

      clangd = {
        command = "${clang-tools}/bin/clangd";
        clangd.fallbackFlags = ["-std=c++2b"];
      };

      cmake-language-server = {
        command = getExe cmake-language-server;
      };

      dprint = {
        command = getExe dprint;
        args = ["lsp"];
      };

      nil = {
        command = getExe nil;
        # alejandro
        config.nil.formatting.command = ["${getExe alejandra}" "-q"];
      };

      pyright = {
        command = "${pyright}/bin/pyright-langserver";
        args = ["--stdio"];
        config = {
          reportMissingTypeStubs = false;
          analysis = {
            typeCheckingMode = "basic";
            autoImportCompletions = true;
          };
        };
      };

      typescript-language-server = {
        command = getExe typescript-language-server;
        args = ["--stdio"];
        config = let
          inlayHints = {
            includeInlayEnumMemberValueHints = true;
            includeInlayFunctionLikeReturnTypeHints = true;
            includeInlayFunctionParameterTypeHints = true;
            includeInlayParameterNameHints = "all";
            includeInlayParameterNameHintsWhenArgumentMatchesName = true;
            includeInlayPropertyDeclarationTypeHints = true;
            includeInlayVariableTypeHints = true;
          };
        in {
          typescript-language-server.source = {
            addMissingImports.ts = true;
            fixAll.ts = true;
            organizeImports.ts = true;
            removeUnusedImports.ts = true;
            sortImports.ts = true;
          };

          typescript = {inherit inlayHints;};
          javascript = {inherit inlayHints;};

          hostInfo = "helix";
        };
      };
    };
  };
  wrapped-helix = symlinkJoin {
    name = "helix-wrapped";
    paths = [
      helix

      # typst lsp
      tinymist

      # C/C++
      clang-tools

      # Markdown
      marksman

      # Nix
      nil
      lldb_19
      # Bash
      bash-language-server

      # Shell
      shellcheck
    ];
    buildInputs = [makeWrapper];
    postBuild = ''
      mkdir -p $out/config/helix
      cp "${toml.generate "config.toml" helix-config}" $out/config/helix/config.toml
      cp "${toml.generate "languages.toml" helix-languages}" $out/config/helix/languages.toml
      wrapProgram $out/bin/hx --set \
      XDG_CONFIG_HOME $out/config
    '';
  };
in
  wrapped-helix
