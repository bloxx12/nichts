{lib, ...}: let
  inherit (lib) mkOption;
  inherit (lib.types) str submodule int ints number listOf;
in {
  options.modules.system.monitors = mkOption {
    description = "\n      List of monitors to use\n    ";
    default = [];
    type = listOf (submodule {
      options = {
        name = mkOption {
          type = str;
          description = "Give your monitor a cute name";
          default = "";
        };
        device = mkOption {
          type = str;
          description = "The actual device name of the monitor";
          default = "eDP-1";
        };
        resolution = mkOption {
          type = submodule {
            options = {
              x = mkOption {
                type = int;
                description = "monitor width";
                default = "1920";
              };
              y = mkOption {
                type = int;
                description = "monitor height";
                default = "1080";
              };
            };
          };
        };
        scale = mkOption {
          type = number;
          description = "monitor scale";
          default = 1.0;
        };
        refresh_rate = mkOption {
          type = int;
          description = "monitor refresh rate (in Hz)";
          default = 60;
        };
        position = mkOption {
          type = submodule {
            options = {
              x = mkOption {
                type = int;
                default = 0;
              };
              y = mkOption {
                type = int;
                default = 0;
              };
            };
          };
          description = "absolute monitor posititon";
          default = {
            x = 0;
            y = 0;
          };
        };
        transform = mkOption {
          type = ints.between 0 3;
          description = "Rotation of the monitor counterclockwise";
          default = 0;
        };
      };
    });
  };
}
