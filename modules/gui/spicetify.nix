{ config, pkgs, lib, inputs, ... }:
with lib; let
    cfg = config.modules.programs.spicetify;
    username = config.modules.other.system.username;
    #inherit (inputs.spicetify-nix.packages.${pkgs.system}.default) spicePkgs; 
    inherit (inputs.spicetify-nix.packages.${pkgs.system}) spicetify-nix; 
in {
    options.modules.programs.spicetify.enable = mkEnableOption "spicetify";
    imports = [ spicetify-nix.homeManagerModule ];
    config = mkIf cfg.enable {
        programs.spicetify = {
            enable = true;
        };
    };
}
