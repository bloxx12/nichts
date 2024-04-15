{ config, inputs, pkgs, ... }:
{
  modules = {
      other = {
          system = {
              hostname = "dyonisos";
              username = "lars";
          };
      };
      hyprland = {
          enable = true;
	  monitor = [",preferred,auto,2"];
	  wallpaper = "wallpaper/nix.png";
      };
  };
}
