{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.programs.ssh;
  inherit (config.modules.other.system) username;
in {
  options.modules.programs.ssh.enable = mkEnableOption "ssh";
  config = {
    programs.ssh.startAgent = true;
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };
}
