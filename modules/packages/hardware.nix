{
  config,
  lib,
  pkgs,
  ...
}: let
in {
environment.systemPackages = with pkgs; lib.mkMerge [
  (mkIf cfg.bluetooth.enable [
    
  ])
];
}
