{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  #   inherit (inputs) quickshell;
  #   inherit (lib.generators) toKeyValue;
in {
  #   environment.systemPackages = with pkgs; [
  #     qt6.qtimageformats # amog
  #     qt6.qt5compat # shader fx
  #     (quickshell.packages.x86_64-linux.default.override {
  #       withJemalloc = true;
  #       withQtSvg = true;
  #       withX11 = true;
  #       withPipewire = true;
  #       withPam = true;
  #       withHyprland = true;
  #     })
  #     pamtester # lockscreen
  #     grim
  #     imagemagick # screenshot
  #   ];
}
