{
  lib,
  pkgs,
  config,
}: let
  inherit (config.modules.other.system) username;
  cfg = config.modules.usrEnv.services.wpaperd;
  inherit (lib) mkIf;
in {
  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.wpaperd = {
        enable = true;
        package = pkgs.wpaperd;
        settings.any = {
          mode = "center";
          path = "/home/vali/projects/nichts/assets/wallpapers/river.png";
        };
      };
    };
  };
}
