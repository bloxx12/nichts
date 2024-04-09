{lib, ...}: let
  inherit (lib) mkForce mkDefault;
in {
  security = {
    # https://github.com/NixOS/nixpkgs/pull/256491
    # no nixpkgs, you are not breaking my system because of "muh rust" delusions again
    # sudo-rs is still a feature-incomplete sudo fork that can and will mess things up
    # also for the love of god stop rewriting things in rust
    sudo-rs.enable = mkForce false;

    # the ol' reliable
    sudo = {
      enable = true;

      # WARNING: wheelNeedsPassword = false means wheel group can execute commands without a password
      # this is especially useful if you are using --target-host option in nixos-rebuild switch
      # however it's also a massive security flaw - which is why it should be replaced with the
      # extraRules you will see below
      wheelNeedsPassword = mkDefault false;

      # only allow members of the wheel group to execute sudo
      # by setting the executable’s permissions accordingly
      execWheelOnly = mkForce true;

      # additional sudo configuration
      extraConfig = ''
        Defaults lecture = never # rollback results in sudo lectures after each reboot, it's somewhat useless anyway
        Defaults pwfeedback # password input feedback - makes typed password visible as asterisks
        Defaults env_keep += "EDITOR PATH DISPLAY" # variables that will be passed to the root account
        Defaults timestamp_timeout = 300 # makes sudo ask for password less often
      '';

      # additional sudo rules
      # this is a better approach for making certain commands sudo-less instead of
      # allowing the wheel users to run *anything* without password
      # FIXME: something is missing, causing the rebuilds to ask for sudo regardless
      extraRules = [
        {
          # allow wheel group to run nixos-rebuild without password
          # this is a less vulnerable alternative to having wheelNeedsPassword = false
          # whitelist switch-to-configuration, allows --target-host option
          # to deploy to remote servers without reading password from STDIN
          groups = ["wheel"];
          commands = let
            currentSystem = "/run/current-system/";
            storePath = "/nix/store/";
          in [
            {
              command = "${storePath}/*/bin/switch-to-configuration";
              options = ["SETENV" "NOPASSWD"];
            }
            {
              command = "${currentSystem}/sw/bin/nix-store";
              options = ["SETENV" "NOPASSWD"];
            }
            {
              command = "${currentSystem}/sw/bin/nix-env";
              options = ["SETENV" "NOPASSWD"];
            }
            {
              command = "${currentSystem}/sw/bin/nixos-rebuild";
              options = ["NOPASSWD"];
            }
            {
              # let wheel group collect garbage without password
              command = "${currentSystem}/sw/bin/nix-collect-garbage";
              options = ["SETENV" "NOPASSWD"];
            }
            {
              # let wheel group interact with systemd without password
              command = "${currentSystem}/sw/bin/systemctl";
              options = ["NOPASSWD"];
            }
          ];
        }
      ];
    };
  };
}
