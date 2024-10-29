{
  config,
  inputs',
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.services.greetd;
  inherit (config.modules.other.system) username;

  hyprlandConfig = pkgs.writeText "greetd-hyprland-config" ''
    misc {
        force_default_wallpaper=0
        focus_on_activate=1
    }

    animations {
        enabled=0
        first_launch_animation=0
    }

    workspace=1,default:true,gapsout:0,gapsin:0,border:false,decorate:false

    #exec-once=[workspace 1;fullscreen;noanim] ${
      pkgs.greetd.${cfg.greeter}
    }/bin/${cfg.greeter} -l; ${
      pkgs.hyprland
    }/bin/hyprctl dispatch exit
    #exec-once=${
      pkgs.hyprland
    }/bin/hyprctl dispatch focuswindow ${cfg.greeter}
  '';
in {
  options.modules.services.greetd = {
    enable = mkEnableOption "greetd";
    greeter = mkOption {
      description = "greetd frontend to use";
      type = types.str;
    };
    launchOptions = mkOption {
      description = "/etc/greetd/environments as list of strings";
      type = with types; listOf str;
    };
  };

  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings.default_session = {
        command = "${
          pkgs.hyprland
        }/bin/Hyprland --config ${hyprlandConfig}";
        user = username;
      };
    };

    environment.etc."greetd/environments".text =
      concatStringsSep "\n" cfg.launchOptions;
  };
}
