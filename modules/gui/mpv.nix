{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.usrEnv.programs.media.mpv;
  inherit (config.modules.other.system) username;
  inherit (lib) mkIf;
in {
  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.mpv = {
        enable = true;
        config = {
          hwdec = "auto";
          volume = 50;
          osc = "no";
          osd-bar = "no";
          border = "no";
        };
        scripts = with pkgs.mpvScripts; [mpris thumbfast sponsorblock uosc];
      };
    };
  };
}
