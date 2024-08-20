{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.system.programs.steam;
in {
  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      # extraCompatPackages = with pkgs; [proton-ge-bin];
    };
    # See
    # https://wiki.nixos.org/wiki/GameMode
    programs.gamemode.enable = true;
  };
}
