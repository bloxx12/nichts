{ pkgs, lib, config, callPackage, ... }:
with lib;
let
  username = config.modules.other.system.username;
  cfg = config.modules.programs.nh;
in {
  options.modules.programs.nh.enable = mkEnableOption "nh";

  config = mkIf cfg.enable {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/vali/repos/nichts";
    };
  };
}
