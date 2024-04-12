{ config, lib, pkgs, ... }:
with lib; let 
    cfg = config.myOptions.programs.ssh;
    username = config.myOptions.other.system.username;
in  {
    options.myOptions.programs.ssh.enable = mkEnableOption "ssh";

    config = mkIf cfg.enable {
            programs.ssh = {
                startAgent = true;
            };
    };

} 
