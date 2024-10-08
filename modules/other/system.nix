{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.other.system;
in {
  options.modules.other.system = {
    hostname = mkOption {
      description = "hostname for this system";
      type = types.str;
    };

    username = mkOption {
      description = "username for this system";
      type = types.str;
    };

    gitPath = mkOption {
      description = "path to the flake directory";
      type = types.str;
    };
  };

  config = {
    users.users.${cfg.username} = {
      isNormalUser = true;
      extraGroups = ["wheel" "networking"];
    };
  };
}
