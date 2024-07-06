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
    home-manager.users.${username} = {
      imports = [inputs.ags.homeManagerModules.default];
      programs.ags = {
        enable = true;
        configDir = ./config;
        extraPackages = with pkgs; [
          ags
          bun
          gtksourceview
          webkitgtk
          accountsservice
        ];
      };
    };
  };
}
