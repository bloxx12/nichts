{lib, ...}:
with lib; {
  options.modules.other.system.monitors = mkOption {
    description = "\n      List of monitors to use\n    ";
    default = [];
    type = with types;
      types.listOf (submodule {
        options = {
          name = mkOption {
            type = types.str;
            description = "Give your monitor a cute name";
            default = "monitor0(I am lazy)";
          };
          device = mkOption {
            type = types.str;
            description = "The actual device name of the monitor";
          };
          resolution = mkOption {
            type = types.submodule {
              options = {
                x = mkOption {
                  type = types.int;
                  description = "monitor width";
                  default = "1920";
                };
                y = mkOption {
                  type = types.int;
                  description = "monitor height";
                  default = "1080";
                };
              };
            };
          };
          scale = mkOption {
            type = types.number;
            description = "monitor scale";
            default = 1.0;
          };
          refresh_rate = mkOption {
            type = types.int;
            description = "monitor refresh rate (in Hz)";
            default = 60;
          };
          position = mkOption {
            type = types.submodule {
              options = {
                x = mkOption {
                  type = types.int;
                  default = 0;
                };
                y = mkOption {
                  type = types.int;
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
            type = types.ints.between 0 3;
            description = "Rotation of the monitor counterclockwise";
            default = 0;
          };
        };
      });
  };
}
