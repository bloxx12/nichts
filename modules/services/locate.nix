{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.usrEnv.services.locate;
  inherit (lib) mkIf;
in {
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [plocate];
    services.locate = {
      enable = true;
      interval = "hourly";
      package = pkgs.plocate;
    };
  };
}
