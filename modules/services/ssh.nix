{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  options.modules.programs.ssh.enable = mkEnableOption "ssh";
  config = {
    programs.ssh.startAgent = true;
    services.openssh = {
      enable = true;
      ports = [8997];
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };
}
