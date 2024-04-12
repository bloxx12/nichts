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
	  monitor = ",preferred,auto,1";
      };
  };
}
