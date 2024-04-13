{ config, lib, pkgs, ... }:
with lib; let 
    cfg = config.modules.programs.ssh;
    username = config.modules.other.system.username;
in  {
    options.modules.programs.ssh.enable = mkEnableOption "ssh";

    config = mkIf cfg.enable {
            programs.ssh = {
                startAgent = true;
            };
    };

} 
