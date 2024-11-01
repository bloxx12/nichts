{lib, ...}: let
  inherit (lib) mkEnableOption;
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
