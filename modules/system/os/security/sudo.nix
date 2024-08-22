{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkForce mkDefault;
in {
  security = {
    sudo-rs.enable = mkForce false;
    sudo = {
      enable = true;
      # We use the default sudo package, but with insults if we
      # fail to provide the correct password
      package = pkgs.sudo.override {withInsults = true;};

      # Wheel user should need the password to execute sudo commands
      wheelNeedsPassword = mkDefault true;

      # BUT, only wheel users should be able to use sudo.
      execWheelOnly = mkForce true;
    };
  };
}
