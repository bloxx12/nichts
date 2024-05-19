# Taken from: https://github.com/hlissner/dotfiles/blob/master/modules/editors/emacs.nix
{ config, lib, pkgs, ... }:

with lib;
# with lib.my;
let
  cfg = config.modules.editors.emacs;
  forgeUrl = "https://github.com";
  repoUrl = "${forgeUrl}/doomemacs/doomemacs";
  configRepoUrl = "${forgeUrl}/bloxx12/doom-emacs-config";
in {
  options.modules.editors.emacs = {
    enable = mkEnableOption "emacs";
    doom.enable = mkEnableOption "doom";
  };

  config = mkIf cfg.enable {
    # Why is this needed?
    # nixpkgs.overlays = [ inputs.emacs-overlay.overlay ];

    environment.systemPackages = with pkgs; [
      ## Emacs itself
      emacs
      binutils # native-comp needs 'as', provided by this
      # 28.2 + native-comp
      ((emacsPackagesFor emacsNativeComp).emacsWithPackages
        (epkgs: [ epkgs.vterm ]))

      ## Doom dependencies
      git
      (ripgrep.override { withPCRE2 = true; })
      gnutls # for TLS connectivity

      ## Optional dependencies
      fd # faster projectile indexing
      imagemagick # for image-dired
      zstd # for undo-fu-session/undo-tree compression

      ## Module dependencies
      # :checkers spell
      (aspellWithDicts (ds: with ds; [ en en-computers en-science ]))
      # :tools editorconfig
      editorconfig-core-c # per-project style config
      # :tools lookup & :lang org +roam
      sqlite
      # :lang latex & :lang org (latex previews)
      texlive.combined.scheme-medium
      # :lang beancount
      beancount
    ];

    environment.sessionVariables.PATH = [ "$XDG_CONFIG_HOME/emacs/bin" ];

    # modules.shell.zsh.rcFiles = [ "${configDir}/emacs/aliases.zsh" ];

    fonts.fonts = [ pkgs.emacs-all-the-icons-fonts ];

    system.userActivationScripts = mkIf cfg.doom.enable {
      installDoomEmacs = ''
        if [ ! -d "$XDG_CONFIG_HOME/emacs" ]; then
           git clone --depth=1 --single-branch "${repoUrl}" "$XDG_CONFIG_HOME/emacs"
           git clone "${configRepoUrl}" "$XDG_CONFIG_HOME/doom"
        fi
      '';
    };
  };
}
