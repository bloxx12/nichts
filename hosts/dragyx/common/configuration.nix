{ config, pkgs, ... }:

let
  username = config.modules.other.system.username;
in
{
  imports = [
    ../../../options/common/pin-registry.nix
    ../../../options/common/preserve-system.nix
    ../../../options/desktop/fonts.nix
  ];


  services.locate = {
    enable = true;
    interval = "hourly";
    package = pkgs.plocate;
    localuser = null;
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  home-manager.users.${username} = {
    programs.firefox.profiles = {
      main = {
        id = 0;
        isDefault = true;
        search.default = "DuckDuckGo";
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          bitwarden
          darkreader
          maya-dark
        ];
        search.force = true;
      };
    };
  };

}
