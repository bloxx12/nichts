{
  config,
  lib,
  #system,
  inputs,
  pkgs,
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
      quickshell.packages.${system}.default
      pamtester
    ];
    home-manager.users.${username}.xdg.configFile."quickshell/manifest.conf".text = toKeyValue {} {
      bar = "${./bar}";
    };
  };
}
