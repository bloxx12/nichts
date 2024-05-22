{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.programs.mpv;
  username = config.modules.other.system.username;
in {
  options.modules.programs.mpv.enable = mkEnableOption "mpv";

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
