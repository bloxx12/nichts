{ config, lib, pkgs, ... }:
with lib; let
    cfg = config.myOptions.programs.obs;
    username = config.myOptions.other.system.username;
in  {
    options.myOptions.programs.obs.enable = mkEnableOption "obs";

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
