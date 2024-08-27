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
      (emacs29-pgtk.override {withNativeCompilation = true;}))
    .emacsWithPackages (epkgs:
      with epkgs; [
        # alert
        # all-the-icons
        # all-the-icons-dired
        # avy
        # beacon
        # catppuccin-theme
        # cask-mode
        # company
        # crux
        # dimmer
        # dired-du
        # dired-open
        # direnv
        # dirvish
        # doom-modeline
        # editorconfig
        # emacs-all-the-icons-fonts
        # evil
        # evil-collection
        # evil-commentary
        # evil-goggles
        # flycheck
        # flycheck-relint
        # flymake
        # form-feed
        # general
        # hl-todo
        # ligature
        # lsp-mode
        # lsp-treemacs
        # lsp-ui
        # macrostep
        # magit
        # markdown-mode
        # modus-themes
        # move-text
        # org-cliplink
        # org-contacts
        # org-pomodoro
        # nano-theme
        # no-littering
        # nov
        # paredit
        # peep-dired
        # projectile
        # rainbow-delimiters
        # rainbow-mode
        # relint
        # ripgrep
        # smartparens
        # string-inflection
        # svg-lib
        # tldr
        # toc-org
        # treesit-grammars.with-all-grammars
        # treemacs
        # treemacs-evil
        # treemacs-projectile
        # treemacs-magit
        # tree-sitter
        # undo-tree
        # use-package
        # vertico
        # vertico-posframe
        vterm
        # vterm-toggle
        # which-key
        # whitespace-cleanup-mode
        # wakatime-mode
        # ws-butler
      ]));
in {
  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      home.packages = with pkgs; [
        # needed my native-comp
        binutils
        # Emacs itself
        custom-emacs

        # Doom dependencies
        git
        ripgrep
        gnutls

        ## Optional dependencies
        fd # faster projectile indexing
        imagemagick # for image-dired
        # (mkIf (config.programs.gnupg.agent.enable)
        #   pinentry-emacs) # in-emacs gnupg prompts
        zstd # for undo-fu-session/undo-tree compression

        ## Module dependencies
        # :checkers spell
        (aspellWithDicts (ds: with ds; [de en en-computers en-science]))
        # :tools editorconfig
        editorconfig-core-c # per-project style config
        # :tools lookup & :lang org +roam
        sqlite
        # :lang latex & :lang org (latex previews)
        texlive.combined.scheme-medium
        # :lang beancount
        beancount
        fava
        # :lang nix
        age
      ];

      environment.variables.PATH = ["$XDG_CONFIG_HOME/emacs/bin"];

      services.emacs = {
        enable = true;
        package = custom-emacs;
      };
    };
  };
}
