{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.modules.other.system) username;
  inherit (lib) mkIf;
  cfg = config.modules.system.programs.eza;
in {
  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.zoxide = {
        enable = true;
        package = pkgs.zoxide;

        enableNushellIntegration = true;
        enableBashIntegration = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
      };
    };
  };
}
