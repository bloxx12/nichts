{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
with lib; let
  username = config.modules.other.system.username;
  cfg = config.modules.programs.steam;
in {
  options.modules.programs.steam = {
    enable = mkEnableOption "steam";
    gamescope = mkEnableOption "gamescope";
  };

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = mkIf cfg.gamescope true;
    };
    home-manager.users.${username} = {};
  };
}
