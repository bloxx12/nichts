{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.meta.mainUser) username;
in {
  home-manager.users.${username}.programs.atuin = {
    enable = true;
    package = pkgs.atuin;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };
}
