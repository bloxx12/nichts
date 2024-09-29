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
      protontricks.enable = true;
      package = pkgs.steam.override {
        extraEnv = {
          MANGOHUD = true;
          SDL_VIDEODRIVER = "x11";
        };

        extraLibraries = p:
          with p; [
            atk
          ];
      };
      gamescopeSession.enable = true;
      extraCompatPackages = with pkgs; [proton-ge-bin.steamcompattool];
    };
    # See
    # https://wiki.nixos.org/wiki/GameMode
    programs.gamemode.enable = true;
  };
}
