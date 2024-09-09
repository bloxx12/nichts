{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.modules.other.system) username;
  inherit (lib) mkIf;
  cfg = config.modules.system.programs.oh-my-posh;
in {
  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.thefuck = {
        enable = true;
        package = pkgs.thefuck;
        enableInstantMode = true;
        enableNushellIntegration = true;
        enableBashIntegration = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
      };
    };
  };
}
