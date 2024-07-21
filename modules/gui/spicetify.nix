{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  cfg = config.modules.system.programs.spotify;
  inherit (config.modules.other.system) username;
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
  # inherit (inputs.spicetify-nix.packages.${pkgs.system}) spicetify-nix;
in {
  config = lib.mkIf cfg.enable {
    home-manager.users.${username} = {
      imports = [inputs.spicetify-nix.homeManagerModule];
      programs.spicetify = {
        enable = true;
        spotifyPackage = pkgs.spotify;
        #theme = spicePkgs.themes.Onepunch;
        colorScheme = "mocha";
        enabledExtensions = with spicePkgs.extensions; [
          shuffle
          adblock
          genre
          playlistIcons
        ];
      };
    };
  };
}
