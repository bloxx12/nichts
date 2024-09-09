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
    ]);

  custom-emacs = with newpkgs; ((emacsPackagesFor (emacs-pgtk.override {
      withNativeCompilation = true;
      withTreeSitter = true;
    }))
    .emacsWithPackages (epkgs:
      with epkgs; [
        avy
        better-jumper
        catppuccin-theme
        cape
        corfu
        consult
        crux
        cmake-font-lock
        diminish
        (trivialBuild {
          pname = "on.el";
          src = pkgs.fetchFromGitLab {
            owner = "ajgrf";
            repo = "on.el";
            rev = "3cf623e1";
            sha256 = "sha256-gtSVCpQwv4Ui9VpW7SXnsXIkfHN/6laMLqHTezDcMZg=";
          };
          version = "0.1.0";
        })
        direnv
        dirvish
        doom-modeline
        editorconfig
        face-explorer
        flycheck
        fontaine
        frames-only-mode
        fussy
        gcmh
        groovy-mode
        just-mode
        kotlin-mode
        lsp-mode
        lsp-treemacs
        lsp-ui
        magit
        markdown-mode
        meow
        meow-tree-sitter
        mode-line-bell
        nasm-mode
        nix-mode
        reformatter # required by nix mode

        projectile
        peep-dired
        persist-state
        rainbow-mode
        no-littering
        suggest
        string-inflection
        tldr
        treesit-auto
        treesit-grammars.with-all-grammars
        treemacs
        treemacs-projectile
        treemacs-magit
        undo-tree
        use-package
        vertico
        vterm
        which-key
        ws-butler
        zoom
      ]));
in {
  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      home.packages = with pkgs; [
        custom-emacs
        clang-tools
      ];

      services.emacs = {
        enable = false;
        package = custom-emacs;
      };
    };
  };
}
