{ config, lib, pkgs, ... }:
with lib; let
    cfg = config.modules.programs.emacs;
    username = config.modules.other.system.username;
in  {
    options.modules.programs.emacs.enable = mkEnableOption "emacs";

    config = mkIf cfg.enable {
        home-manager.users.${username} = {
            programs.emacs = {
                enable = true;
                package = pkgs.emacs;
                extraConfig = ''
                    (setq standard-indent 2)
                    (require 'evil)
                    (evil-mode 1)
                '';
                extraPackages = epkgs: [
                epkgs.evil

                ]; 
            };
        };
    };

} 
