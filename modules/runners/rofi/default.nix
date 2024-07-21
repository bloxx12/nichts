{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.modules.other.system) username;
  cfg = config.modules.usrEnv.programs.launchers.rofi;
  inherit (lib) mkIf;
in {
  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
        location = "center";
        extraConfig = {
          modi = "drun,filebrowser";
          drun-display-format = " {name} ";
          sidebar-mode = true;
          matching = "prefix";
          scoll-method = 0;
          disable_history = false;
          show-icons = true;
          display-drun = " Run";
          display-run = " Run";
          display-filebrowser = " Files";
        };
      };
    };
  };
}
