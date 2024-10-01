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
  # newpkgs =
  #   pkgs.appendOverlays
  #   (with inputs.emacs-overlay.overlays; [
  #     emacs
  #     package
  #   ]);

  # custom-emacs = with newpkgs;
  #   (emacsPackagesFor emacs-pgtk)
  #   .emacsWithPackages (epkgs:
  #     with epkgs; [
  #       vterm
  #       treesit-grammars.with-all-grammars
  #     ]);
in {
  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      home.packages = with pkgs; [
        # custom-emacs
        clang-tools
        emacs30-pgtk
        binutils

        ## Doom dependencies
        git
        ripgrep
        gnutls # for TLS connectivity

        ## Optional dependencies
        fd # faster projectile indexing
        imagemagick # for image-dired
        (mkIf (config.programs.gnupg.agent.enable)
          pinentry-emacs) # in-emacs gnupg prompts
        zstd # for undo-fu-session/undo-tree compression
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
        package = pkgs.emacs30-pgtk;
      };
    };
  };
}
