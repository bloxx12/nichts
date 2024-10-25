{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  cfg = config.modules.usrEnv.services.kmscon;
in {
  services.kmscon = mkIf cfg.enable {
    enable = false;
    hwRender = true;
    fonts = [
      {
        name = "Iosevka";
        package = pkgs.iosevka;
      }
    ];
    extraOptions = "--term xterm-256color";
    extraConfig = ''
      font-size=18
      xkb-layout=${config.console.keyMap}
    '';
  };
}
