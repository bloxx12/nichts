{ pkgs, lib, config, ... }:
with lib; let
  cfg = config.myOptions.programs.awesome;
in {
  options.myOptions.programs.awesome.enable = mkEnableOption "awesome";

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      xkb.layout =  "de";
      windowManager.awesome = {
          enable = true;
          luaModules = with pkgs.luaPackages; [
          luarocks
          luadbi-mysql
          ];
      };
    };
  };
}
