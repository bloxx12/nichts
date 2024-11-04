{
  config,
  lib,
  ...
}: let
  cfg = config.modules.programs.nh;
  inherit (config.modules.other.system) username;
  inherit (lib) mkEnableOption mkIf;
in {
  options.modules.programs.nh.enable = mkEnableOption "nh";

  config = mkIf cfg.enable {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/${username}/repos/projects/nichts";
    };
  };
}
