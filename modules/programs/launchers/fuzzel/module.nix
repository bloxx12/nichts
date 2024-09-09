{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config.modules.other.system) username;
  cfg = config.modules.usrEnv.programs.launchers.fuzzel;
in {
  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.fuzzel = {
        enable = true;
        package = pkgs.fuzzel;
        settings = {
          main = {
            terminal = "${pkgs.foot}/bin/foot -e";
            # make fuzzel appear on fullscreen windows
            layer = "overlay";
            icon-theme = "Papirus-Dark";
            font = "Lexend:weight=regular:size=14";
          };
          # background = "000000";
        };
      };
    };
  };
}
