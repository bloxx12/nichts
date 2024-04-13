{ config, inputs, pkgs, ... }:
let
  username = config.modules.other.system.username;
in {
    home-manager.users.${username} = {
        home.packages = let
          fenix = inputs.fenix.packages.${pkgs.system};

        in with pkgs; [
        ];
    };
}
