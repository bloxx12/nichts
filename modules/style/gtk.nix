{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.usrEnv.style.gtk;
in {
  config = mkIf cfg.enable {
    programs.dconf.enable = true; # NOTE: we need this or gtk breaks
  };
}
