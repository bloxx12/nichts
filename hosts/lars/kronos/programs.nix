{ config, inputs, pkgs, ... }:
let
  username = config.myOptions.other.system.username;
in {
    home-manager.users.${username} = {
        home.packages = let
          fenix = inputs.fenix.packages.${pkgs.system};

        in with pkgs; [
        ];
    };
}
