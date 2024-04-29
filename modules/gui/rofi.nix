{ config, pkgs, lib, ... }: 

with lib;
let 
  username = config.modules.other.system.username;
  cfg = config.modules.programs.rofi;
in {
  options.modules.programs.rofi.enable = mkEnableOption "rofi";
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ rofi ];
  };
}

