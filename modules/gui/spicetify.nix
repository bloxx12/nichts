{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  cfg = config.modules.programs.spicetify;
  username = config.modules.other.system.username;
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
  # inherit (inputs.spicetify-nix.packages.${pkgs.system}) spicetify-nix;
in {
  options.modules.programs.spicetify.enable = lib.mkEnableOption "spicetify";
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
          hidePodcasts
          adblock
        ];
      };
    };
  };
}
