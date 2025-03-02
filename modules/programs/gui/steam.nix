{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  cfg = config.modules.system.programs.steam;
in {
  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      package = pkgs.steam.override {
        extraEnv = {
          MANGOHUD = true;
          SDL_VIDEODRIVER = "x11";
        };

        extraLibraries = p:
          builtins.attrValues {
            inherit (p) atk;
          };
      };

      gamescopeSession.enable = true;
      extraCompatPackages = [pkgs.proton-ge-bin.steamcompattool];
    };
    # See
    # https://wiki.nixos.org/wiki/GameMode
    programs.gamemode.enable = true;
  };
}
