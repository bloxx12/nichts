{
  pkgs,
  config,
  ...
}: let
  inherit (config.modules.other.system) username;
in {
  home-manager.users.${username} = {
    home.packages = with pkgs; [gnupg];
    programs.git = {
      enable = true;
      userName = "Charlie Root";
      userEmail = "charlie@charlieroot.dev";
      signing = {
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILPiRe9OH/VtWFWyy5QbAVcN7CLxr4zUtRCwmxD6aeN6";
        signByDefault = true;
      };
      extraConfig.gpg.format = "ssh";
    };
  };
}
