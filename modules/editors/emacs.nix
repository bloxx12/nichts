{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.modules.editors.emacs;
  inherit (config.modules.other.system) username;
  inherit (lib) mkEnableOption mkIf;

  newpkgs =
    pkgs.appendOverlays
    (with inputs.emacs-overlay.overlays; [
      emacs
      package

      (final: prev: {
        tree-sitter = prev.tree-sitter.override {
          extraGrammars = {
            tree-sitter-qmljs = {
              version = "master";
              src = pkgs.fetchFromGitHub {
                owner = "yuja";
                repo = "tree-sitter-qmljs";
                rev = "35ead5b9955cdb29bcf709d622fa960ff33992b6";
                sha256 = "jT47lEGuk6YUjcHB0ZMyL3i5PqyUaCQmt0j78cUpy8Q=";
              };
            };
          };
        };
      })
    ]);

  tree-sitter-parsers = grammars:
    with grammars; [
      tree-sitter-bash
      tree-sitter-c
      tree-sitter-c-sharp
      tree-sitter-cmake
      tree-sitter-cpp
      tree-sitter-css
      tree-sitter-dot
      tree-sitter-elisp
      tree-sitter-glsl
      tree-sitter-html
      tree-sitter-java
      tree-sitter-javascript
      tree-sitter-json
      tree-sitter-json5
      tree-sitter-kotlin
      tree-sitter-latex
      tree-sitter-llvm
      tree-sitter-lua
      tree-sitter-make
      tree-sitter-markdown
      tree-sitter-markdown-inline
      tree-sitter-nickel
      tree-sitter-nix
      tree-sitter-prisma
      tree-sitter-python
      tree-sitter-qmljs
      tree-sitter-regex
      tree-sitter-rust
      tree-sitter-scss
      tree-sitter-sql
      tree-sitter-toml
      tree-sitter-tsx
      tree-sitter-typescript
      tree-sitter-vim
      tree-sitter-yaml
    ];

  custom-emacs = with newpkgs; ((emacsPackagesFor (emacs29-pgtk.override {withNativeCompilation = true;})).emacsWithPackages (epkgs:
    with epkgs; let
      qml-ts-mode = trivialBuild {
        pname = "qml-ts-mode";
        version = "master";
        src = fetchFromGitHub {
          owner = "outfoxxed";
          repo = "qml-ts-mode";
          rev = "b24b9e78305ed045baa136782623ad16de01b7b8";
          sha256 = "PgXm/a92cX5zjA9blTrIRH7DfOUczRwb9oBcMMEzF2I=";
        };
      };
    in [
      altert
      all-the-icons
      all-the-icons-dired
      autorevert
      avy
      beacon
      #better-jumper
      company
      crux
      #cmake-font-lock
      dimmer
      dired-du
      direnv
      doom-modeline
      editorconfig
      evil
      evil-collection
      evil-goggles
      # face-explorer
      flycheck
      form-feed
      general
      # frames-only-mode
      # fussy
      # groovy-mode
      hl-todo
      # just-mode
      kotlin-mode
      ligature
      lsp-mode
      lsp-treemacs
      lsp-ui
      lsp-java
      magit
      markdown-mode
      nasm-mode
      nix-mode
      reformatter # required by nix mode
      pdf-tools
      peep-dired
      projectile
      qml-ts-mode
      rainbow-delimiters
      rainbow-mode
      select
      string-inflection
      tldr
      toc-org
      (treesit-grammars.with-grammars (grammars: tree-sitter-parsers grammars))
      treemacs
      treemacs-evil
      treemacs-projectile
      treemacs-magit
      undo-tree
      use-package
      vertico
      vterm
      vterm-toggle
      which-key
      wakatime-mode
      ws-butler
    ]));
in {
  options.modules.editors.emacs = {
    enable = mkEnableOption "emacs";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      home.packages = [custom-emacs];
      services.emacs = {
        enable = true;
        package = custom-emacs;
      };
    };
  };
}
