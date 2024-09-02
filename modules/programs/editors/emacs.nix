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
  emacsOverlay =
    pkgs.appendOverlays
    (with inputs.emacs-overlay.overlays; [
      emacs
      package
    ]);

  customEmacs = with emacsOverlay; ((emacsPackagesFor
      (emacs29-pgtk.override {withNativeCompilation = true;}))
    .emacsWithPackages (epkgs:
      with epkgs; [
        vterm
      ]));
in {
  config = mkIf cfg.enable {
    environment.variables.PATH = ["$XDG_CONFIG_HOME/emacs/bin"];
    home-manager.users.${username} = {
      home.packages = with pkgs; [
        # needed by native-comp
        binutils
        # Emacs itself
        customEmacs

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

        # Module dependencies
        # :checkers spell
        (aspellWithDicts (ds: with ds; [de en en-computers en-science]))
        # :tools editorconfig
        editorconfig-core-c # per-project style config
        # :tools lookup & :lang org +roam
        sqlite
      ];

      services.emacs = {
        enable = true;
        package = customEmacs;
      };
    };
  };
}
