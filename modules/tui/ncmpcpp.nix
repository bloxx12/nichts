{ config, lib, pkgs, ... }:
with lib; let
    cfg = config.myOptions.programs.ncmpcpp
    username = config.myOptions.other.system.username;
in  {
    options.myOptions.programs.ncmpcpp.enable = mkEnableOption "ncmpcpp";

    config = mkIf cfg.enable {
        home-manager.users.${username} = {
            programs.ncmpcpp = {
                enable = true;
                mpdMusicDir = "/home/vali/Nextcloud/Media/Music";
                xdg.configFile."ncmpcpp/config".source = ./config;
            };
        };
    };

} 
