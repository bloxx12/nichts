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
      programs.oh-my-posh = {
        enable = true;
        package = pkgs.oh-my-posh;
        enableNushellIntegration = true;
        enableBashIntegration = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
        useTheme = "zash";
        settings = {
        };
      };
    };
  };
}
