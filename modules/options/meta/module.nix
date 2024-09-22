{
  config,
  lib,
  ...
}: let
  inherit (builtins) elemAt;
  inherit (lib) options types;
  inherit (options) mkOption;
  inherit (types) listOf str;
in {
  options.meta = {
    users = mkOption {
      type = listOf str;
      default = ["cr"];
      description = ''
        A list of users on a system.
      '';
    };
    mainUser = {
      username = mkOption {
        type = str;
        default = elemAt config.meta.users 0;
        description = ''
          The main user for each system. This is the first element of the list of users by default.
        '';
      };
      gitSigningKey = mkOption {
        type = str;
        description = ''
          The main user's git signing key, used to automatically sing git commits with this key
        '';
      };
    };
  };
}
