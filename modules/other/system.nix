{lib, ...}: let
  inherit (lib) mkOption types;
in {
  options.modules.other.system = {
    username = mkOption {
      description = "username for this system";
      type = types.str;
    };
  };
}
