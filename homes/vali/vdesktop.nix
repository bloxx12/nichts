{ inputs, outputs, pkgs, user, ... }:
{
    imports = [

    ];
    xdg.configHome = "/home/${user}/.config/";
    programs.home-manager.enable = true;
    home = {
      stateVersion = "23.11";
      username = "${user}";
      homeDirectory = "/home/${user}";
    };
  }
