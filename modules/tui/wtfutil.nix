{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.modules.programs.wtfutil;
  inherit (config.modules.other.system) username;
in {
  options.modules.programs.wtfutil.enable = mkEnableOption "wtfutil";
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wtf
    ];
    home-manager.users.${username}.xdg.configFile."wtf/config.yml".text = builtins.toJSON {
      wtf = {
        refreshInterval = 1;
        colors = {
          border = {
            focusable = "darkslateblue";
            focused = "orange";
            normal = "gray";
          };
        };
        grid = {
          columns = "[15, 15, 15, 15, 40]";
          rows = "[10, 10, 10, 4, 4, 90]";
        };
        mods = {
          clocks_a = {
            enabled = true;
            locations = {Zurich = "Europe/Zurich";};
            position = {
              top = 1;
              left = 1;
              height = 1;
              width = 1;
            };
            refreshInterval = 15;
            sort = "alphabetical";
            title = "Clock!";
            type = "clocks";
            colors = {
              rows = {
                even = "lightblue";
                odd = "white";
              };
            };
          };
          git = {
            enabled = true;
            showModuleName = true;
            commitCount = 5;
            commitFormat = "[forestgreen]%h [%grey]%cd [white]%s [grey]%an[white]";
            dateFormat = "%H:%M %d %b %y";
            position = {
              top = 1;
              left = 5;
              height = 5;
              width = 1;
            };
            refreshInterval = 10;
            repositories = [
              "/home/${username}/repos/nichts"
              "/home/${username}/repos/analysis-1-cheatsheet"
            ];
          };
          ipapi = {
            enabled = true;
            refreshInterval = 150;
            position = {
              top = 1;
              left = 2;
              height = 1;
              width = 1;
            };
            colors = {
              name = "red";
              value = "white";
            };
          };
          lunarphase = {
            enabled = false;
            refreshInterval = "5h";
            language = "en";
            position = {
              top = 3;
              left = 5;
              height = 7;
              width = 3;
            };
          };
          power = {
            enabled = true;
            refreshInterval = 15;
            position = {
              top = 5;
              left = 0;
              height = 2;
              width = 1;
            };
          };
          resourceusage = {
            enabled = true;
            refreshInterval = 1;
            showCPU = true;
            showMem = true;
            showSwp = true;
            cpuCombined = false;
            position = {
              top = 1;
              left = 1;
              height = 1;
              width = 1;
            };
          };
          security = {
            enabled = true;
            refreshInterval = "1h";
            position = {
              top = 1;
              left = 2;
              height = 1;
              width = 1;
            };
          };
        };
      };
    };
  };
}
