{
  inputs',
  pkgs,
  lib,
  ...
}: let
  inherit (inputs') quickshell;
  inherit (lib.generators) toKeyValue;
in {
  home.packages = with pkgs; [
    qt6.qtimageformats # amog
    qt6.qt5compat # shader fx
    quickshell.packages.default
    pamtester # lockscreen
    grim
    imagemagick # screenshot
  ];

  xdg.configFile."quickshell/manifest.conf".text = toKeyValue {} {
    shell = "${./shell}";
    lockscreen = "${./lockscreen}";
  };
}
