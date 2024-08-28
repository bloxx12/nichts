{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.usrEnv.style.gtk;
  inherit (config.modules.other.system) username;
  inherit (config.modules.usrEnv.style.gtk) theme iconTheme;
in {
  config = mkIf cfg.enable {
    programs.dconf.enable = true; # NOTE: we need this or gtk breaks
    home-manager.users.${username} = {
      gtk = {
        enable = true;
        theme = {
          inherit (theme) name package;
        };
        iconTheme = {
          inherit (iconTheme) name package;
        };
      };
    };
  };
}
