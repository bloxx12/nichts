{
  config,
  pkgs,
  self,
  ...
}: let
  inherit (config.meta.mainUser) username;
in {
  users = {
    mutableUsers = false;
    users = {
      ${username} = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "networking"
          "video"
          "networkmanager"
          "audio"
          "nix"
        ];
        shell = self.packages.${pkgs.stdenv.system}.fish;
        # hashedPasswordFile = "/etc/passwords/cr";
      };
      # root.hashedPasswordFile = "/persist/passwords/root";
    };
  };
}
