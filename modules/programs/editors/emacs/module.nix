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

  custom-emacs = with newpkgs; ((emacsPackagesFor (emacs30-pgtk.override {
      withNativeCompilation = true;
      withTreeSitter = true;
    }))
    .emacsWithPackages (epkgs:
      with epkgs; [
        avy
        better-jumper
        catppuccin-theme
        company
        crux
        cmake-font-lock
        direnv
        doom-modeline
        editorconfig
        face-explorer
        flycheck
        frames-only-mode
        fussy
        groovy-mode
        just-mode
        kotlin-mode
        lsp-mode
        lsp-treemacs
        lsp-ui
        lsp-java
        magit
        markdown-mode
        meow
        meow-tree-sitter
        nasm-mode
        nix-mode
        reformatter # required by nix mode
        projectile
        peep-dired
        rainbow-mode
        no-littering
        string-inflection
        tldr
        treesit-grammars.with-all-grammars
        treemacs
        treemacs-evil
        treemacs-projectile
        treemacs-magit
        undo-tree
        use-package
        vertico
        vterm
        which-key
        ws-butler
      ]));
in {
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
