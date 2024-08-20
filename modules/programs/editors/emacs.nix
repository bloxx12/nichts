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

  tree-sitter-parsers = grammars:
    with grammars; [
      tree-sitter-dot
      tree-sitter-elisp
      tree-sitter-markdown
      tree-sitter-markdown-inline
    ];

  custom-emacs = with newpkgs; ((emacsPackagesFor (emacs29-pgtk.override {withNativeCompilation = true;})).emacsWithPackages (epkgs:
    with epkgs; [
      alert
      all-the-icons
      all-the-icons-dired
      avy
      beacon
      catppuccin-theme
      cask-mode
      company
      crux
      dimmer
      dired-du
      dired-open
      direnv
      dirvish
      doom-modeline
      editorconfig
      emacs-all-the-icons-fonts
      evil
      evil-collection
      evil-commentary
      evil-goggles
      flycheck
      flycheck-relint
      flymake
      form-feed
      general
      hl-todo
      ligature
      lsp-mode
      lsp-treemacs
      lsp-ui
      macrostep
      magit
      markdown-mode
      modus-themes
      move-text
      org-cliplink
      org-contacts
      org-pomodoro
      nano-theme
      no-littering
      nov
      paredit
      peep-dired
      projectile
      rainbow-delimiters
      rainbow-mode
      relint
      ripgrep
      smartparens
      string-inflection
      svg-lib
      tldr
      toc-org
      (treesit-grammars.with-grammars tree-sitter-parsers)
      treemacs
      treemacs-evil
      treemacs-projectile
      treemacs-magit
      tree-sitter
      undo-tree
      use-package
      vertico
      vertico-posframe
      vterm
      vterm-toggle
      which-key
      whitespace-cleanup-mode
      wakatime-mode
      ws-butler
    ]));
in {
  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      home.packages = with pkgs; [
        custom-emacs
        clang-tools
        ripgrep
        fd
        imagemagick
        ispell
        mediainfo
        findutils
        graphviz
        djvulibre
        hunspell
        poppler
        sqlite
        unzip
      ];
      services.emacs = {
        enable = true;
        package = custom-emacs;
      };
    };
  };
}
