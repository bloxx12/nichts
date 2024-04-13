{ config, inputs, pkgs, ... }:
{
  modules = {
      other = {
          system = {
              hostname = "kronos";
              username = "lars";
          };
      };
      hyprland = {
          enable = true;
      	  nvidia.enable = true;
			monitor = [
			    "DP-2,2560x1440@144,0x0,1"
			    "DP-1,1920x1080@60,2560x0,1"
			];
      };
      firefox = {
	  enable = true;
      };
  };

  services.getty.autologinUser = "lars";
}
