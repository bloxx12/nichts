{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.programs.steam;
in {
  options.modules.programs.steam = {
    enable = mkEnableOption "steam";
    gamescope = mkEnableOption "gamescope";
  };

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = mkIf cfg.gamescope true;
      extraCompatPackages = with pkgs; [proton-ge-bin];
    };
    # See
    # https://wiki.nixos.org/wiki/GameMode
    programs.gamemode.enable = true;
  };
}
