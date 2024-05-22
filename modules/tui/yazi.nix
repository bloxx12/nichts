{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.yazi;
  username = config.modules.other.system.username;
in {
  options.modules.programs.yazi = {enable = mkEnableOption "yazi";};

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.yazi = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  };
}
