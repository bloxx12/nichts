{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.modules.system.programs.editors.emacs;
  inherit (config.modules.other.system) username;
  inherit (lib) mkIf;

  # Taken from outfoxxed since figuring this out is really annoying.
  newpkgs =
    pkgs.appendOverlays
    (with inputs.emacs-overlay.overlays; [
      emacs
      package

      (_: prev: {
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
      tree-sitter-qmljs
    ];

  emaks = with newpkgs;
    (emacsPackagesFor (emacs-pgtk.override {withNativeCompilation = true;}))
    .emacsWithPackages (epkgs:
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
        vterm
        treesit-grammars.with-all-grammars
        (treesit-grammars.with-grammars (grammars: tree-sitter-parsers grammars))
        qml-ts-mode
      ]);
in {
  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      home.packages = with pkgs; [
        emaks

        nil
        clang-tools
        # emacs30-pgtk
        binutils

        ## Doom dependencies
        git
        ripgrep
        gnutls # for TLS connectivity

        ## Optional dependencies
        fd # faster projectile indexing
        imagemagick # for image-dired
        ## Module dependencies
        # :email mu4e
        mu
        isync
        # :checkers spell
        (aspellWithDicts (ds: with ds; [en en-computers en-science]))
        # :tools editorconfig
        editorconfig-core-c # per-project style config
        # :tools lookup & :lang org +roam
        sqlite
        # :lang latex & :lang org (latex previews)
        texlive.combined.scheme-medium
        # :lang nix
        age
      ];

      services.emacs = {
        enable = true;
        package = emaks;
      };
    };
  };
}
