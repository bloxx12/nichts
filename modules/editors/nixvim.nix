{pkgs, config, lib, ...}:
with lib;
let
  cfg = config.modules.editors.nixvim;
  inherit (inputs.nixvim.packges.${pkgs.system}) nixvim;
in {
  options.modules.editors.nivim.enable = mkEnableOption "nixvim";
  config = mkIf cfg.enable {
    programs.nixvim = {
        enable = true;
    };
  };

}
