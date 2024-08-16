{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.system.programs.zathura;
  inherit (config.modules.other.system) username;
in {
  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.zathura = {
        enable = true;
        options = {
          selection-clipboard = "clipboard";
          adjust-open = "best-fit";
          pages-per-row = "1";
          scroll-page-aware = "true";
          scroll-full-overlap = "0.01";
          scroll-step = "100";
          zoom-min = "10";
          guioptions = "none";
        };
      };
    };
  };
}
