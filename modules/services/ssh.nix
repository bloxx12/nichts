{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  options.modules.programs.ssh.enable = mkEnableOption "ssh";
  config = {
    programs.ssh.startAgent = true;
    # programs.ssh.pubkeyAcceptedKeyTypes = [
    #   "ssh-rsa"
    #   "ecdsa-sha2-nistp521"
    # ];

    services.openssh = {
      enable = true;
      ports = [22];
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };
}
