{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf getExe;
  cfg = config.modules.usrEnv.services.greetd;
in {
  services.greetd = mkIf cfg.enable {
    enable = true;
    restart = true;
    vt = 2;
    settings = {
      default_session = {
        command = ''
          ${getExe pkgs.greetd.tuigreet} \
            -c \"Hyprland\" \
            -r
            -t --time-format "DD.MM.YYYY"
            --asteriks
        '';
      };
    };
  };
}
