{config, ...}: let
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
        homix = true;
        # hashedPasswordFile = "/etc/passwords/cr";
      };
      # root.hashedPasswordFile = "/persist/passwords/root";
    };
  };
}
