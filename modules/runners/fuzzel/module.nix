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
  config = {
    home-manager.users.${username}.programs.fuzzel = mkIf cfg.enable {
      enable = true;
      package = pkgs.fuzzel;
      settings = {
      };
    };
  };
}
