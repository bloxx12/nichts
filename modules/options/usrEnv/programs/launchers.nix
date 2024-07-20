{lib, ...}: let
  inherit (lib.options) mkEnableOption;
in {
  options.modules.usrEnv.programs.launchers = {
    anyrun.enable = mkEnableOption "anyrun application launcher";
    rofi.enable = mkEnableOption "rofi application launcher";
    tofi.enable = mkEnableOption "tofi application launcher";
  };
}
