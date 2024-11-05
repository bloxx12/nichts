{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.system.programs.editors.helix;
  inherit (config.modules.other.system) username;
  inherit (lib) mkIf getExe;
in {
  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.helix.languages = {
        language = let
          extraFormatter = lang: {
            command = getExe pkgs.deno;
            args = ["fmt" "-" "--ext" lang];
          };
        in [
          {
            name = "bash";
            auto-format = true;
            formatter = {
              command = getExe pkgs.shfmt;
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
              command = getExe pkgs.cmake-format;
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
              command = getExe pkgs.black;
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
              command = "${pkgs.lldb_19}/bin/lldb-dap";
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
              command = "${pkgs.gdb}/bin/gdb";
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
            command = getExe pkgs.bash-language-server;
            args = ["start"];
          };

          clangd = {
            command = "${pkgs.clang-tools}/bin/clangd";
            clangd.fallbackFlags = ["-std=c++2b"];
          };

          cmake-language-server = {
            command = getExe pkgs.cmake-language-server;
          };

          dprint = {
            command = getExe pkgs.dprint;
            args = ["lsp"];
          };

          nil = {
            command = getExe pkgs.nil;
            # alejandro
            config.nil.formatting.command = ["${getExe pkgs.alejandra}" "-q"];
          };

          qmlls = {
            command = "${pkgs.kdePackages.full}/bin/qmlls";
          };

          pyright = {
            command = "${pkgs.pyright}/bin/pyright-langserver";
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
            command = getExe pkgs.typescript-language-server;
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
    };
  };
}
