{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  inherit (config.modules.other.system) username;
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
    programs.gamemode.enable = true;
    environment.systemPackages = [pkgs.protonup-ng];
    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/${username}/.steam/root/compatibilitytoolds.d";
    };
  };
}
