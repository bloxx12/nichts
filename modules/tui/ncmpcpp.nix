{ config, lib, pkgs, ... }:
with lib; let
    cfg = config.modules.programs.ncmpcpp;
    username = config.modules.other.system.username;
in  {
    options.modules.programs.ncmpcpp.enable = mkEnableOption "ncmpcpp";

    config = mkIf cfg.enable {
        home-manager.users.${username} = {
            xdg.configFile."ncmpcpp/config".source = ./config;
            programs.ncmpcpp = {
                enable = true;
                mpdMusicDir = "/home/vali/Nextcloud/Media/Music";
            };
        };
    };

} 
