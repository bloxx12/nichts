{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.theming.gtk;
  inherit (config.modules.other.system) username;
  inherit (config.modules.style.gtk) theme iconTheme;
in {
  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      gtk = {
        enable = true;
        theme = {
          inherit (theme) name package;
        };
        iconTheme = {
          inherit (iconTheme) name Package;
        };
      };
    };
  };
}
