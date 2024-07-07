{
  inputs,
  lib,
  config,
  pkgs,
  ...
}
: let
  inherit (config.modules.other.system) username;
  inherit (lib) mkIf mkEnableOption;
  cfg = config.modules.programs.ags;
in {
  options.modules.programs.ags.enable = mkEnableOption "ags";

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      ags
      bun
      ddcutil
      brightnessctl
      gtksourceview
      webkitgtk
      gtksourceview4
      ollama
      python311Packages.material-color-utilities
      python311Packages.pywayland
      pywal
      sassc
      webp-pixbuf-loader
      ydotool
      accountsservice
    ];

    home-manager.users.${username} = {
      imports = [inputs.ags.homeManagerModules.default];
      programs.ags = {
        enable = true;
        configDir = ./config;
      };
    };
  };
}
