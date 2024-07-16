# Taken from: https://github.com/hlissner/dotfiles/blob/master/modules/editors/emacs.nix
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.editors.emacs;
  inherit (config.modules.other.system) username;
  repoUrl = inputs.doomemacs;
  configRepoUrl = inputs.doom-emacs-config;
  emacs-desktop-symbol = pkgs.makeDesktopItem {
    name = "emacsclient";
    desktopName = "Emacs Client";
    exec = "emacsclient -c -a emacs";
  };
in {
  options.modules.editors.emacs = {
    enable = mkEnableOption "emacs";
    doom.enable = mkEnableOption "doom";
  };

  config = mkIf cfg.enable {
    ## Emacs itself as an overlay
    #nixpkgs.overlays = [inputs.emacs-overlay.overlay];
    services.emacs = {
      enable = true;
      package = pkgs.emacs29-pgtk;
    };
    environment.systemPackages = with pkgs; [
      binutils # native-comp needs 'as', provided by this
      emacs-desktop-symbol
      ## Doom dependencies
      git
      ripgrep
      gnutls # for TLS connectivity

      ## Optional dependencies
      fd # faster projectile indexing
      imagemagick # for image-dired
      zstd # for undo-fu-session/undo-tree compression

      ## Module dependencies
      # :checkers spell
      (aspellWithDicts (ds: with ds; [en en-computers en-science de]))
      # :tools editorconfig
      editorconfig-core-c # per-project style config
      # :tools lookup & :lang org +roam
    ];

    environment.variables.PATH = ["/home/vali/.config/emacs/bin"];

    fonts.fonts = [pkgs.emacs-all-the-icons-fonts];

    system.userActivationScripts = mkIf cfg.doom.enable {
      installDoomEmacs = ''
        #!/bin/bash
        if [ ! -d "/home/${username}/.config/emacs" ]; then
           git clone --depth=1 --single-branch "${repoUrl}" "/home/${username}/.config/emacs"
           git clone "${configRepoUrl}" "/home/${username}/.config/doom"
        fi
      '';
    };
  };
}
