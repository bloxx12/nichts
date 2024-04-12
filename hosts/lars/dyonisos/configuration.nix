{ config, inputs, pkgs, ... }:
{
  myOptions = {
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
