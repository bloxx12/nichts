{ config, lib, pkgs, ... }:
with lib; let
    cfg = config.modules.programs.obs;
    username = config.modules.other.system.username;
in  {
    options.modules.programs.obs.enable = mkEnableOption "obs";

    config = mkIf cfg.enable {
        home-manager.users.${username} = {
            programs.obs-studio = {
                enable = true;
                plugins = with pkgs.obs-studio-plugins; [
                    wlrobs
                    obs-backgroundremoval
                    obs-pipewire-audio-capture
                ];

            };
        };
    };

} 
