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
  pkgswithemacs =
    pkgs.appendOverlays
    (with inputs.emacs-overlay.overlays; [
      emacs
      package
    ]);

  custom-emacs = with pkgswithemacs; ((emacsPackagesFor
      (emacs29-pgtk.override {
        withNativeCompilation = true;
        withTreeSitter = true;
      }))
    .emacsWithPackages (epkgs:
      with epkgs; [
        treesit-grammars.with-all-grammars
        vterm
        eshell-prompt-extras
        esh-autosuggest
        fish-completion
        esh-help
        eshell-syntax-highlighting
        pinentry
      ]));
in {
  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      imports = [inputs.nix-doom-emacs-unstraightened.hmModule];
      programs.doom-emacs = {
        enable = true;
        doomDir = ./doom;
        emacs = custom-emacs;
        extraBinPackages = with pkgs; [
          python3
          pinentry-tty
          pinentry-emacs
          # needed by native-comp
          binutils

          # Doom dependencies
          git
          ripgrep
          gnutls

          ## Optional dependencies
          fd # faster projectile indexing
          imagemagick # for image-dired
          zstd # for undo-fu-session/undo-tree compression
          nodePackages.prettier

          # Module dependencies
          # spell
          (aspellWithDicts (ds: with ds; [de en en-computers en-science]))
          # editorconfig
          editorconfig-core-c # per-project style config
          # lookup & org +roam
          sqlite
          # latex & org (latex previews)
          texlive.combined.scheme-medium
          # :lang beancount
          # beancount
          # fava
          # :lang nix
          age
        ];
      };
    };
  };
}
