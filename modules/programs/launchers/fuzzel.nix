{
  config,
  lib,
  pkgs,
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
          icon-theme = "Papirus-Dark";
          font = "ComicShannsMono:weight=bold:size=36";
          terminal = "foot -e";
          # make fuzzel appear on fullscreen windows
          layer = "overlay";
          background = "000000";
        };
      };
    };
  };
}
