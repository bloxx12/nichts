{
  config,
  lib,
  inputs,
  pkgs,
  impurity,
  ...
}: let
  inherit (inputs) quickshell;
  inherit (lib) mkIf mkEnableOption;
  inherit (lib.generators) toKeyValue;
  inherit (config.modules.other.system) username;
  cfg = config.modules.theming.quickshell;
in {
  options.modules.theming.quickshell.enable = mkEnableOption "quickshell";
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      qt6.qtimageformats
      qt6.qt5compat
      quickshell.packages."x86_64-linux".default
      pamtester
    ];
    home-manager.users.${username}.xdg.configFile."quickshell/manifest.conf".text = toKeyValue {} {
      # bar = "${impurity.link ./bar}";
      # bar = "${./bar}";
    };
  };
}
