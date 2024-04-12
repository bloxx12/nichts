{ config, inputs, pkgs, ... }:
{
  myOptions = {
      other = {
          system = {
              hostname = "kronos";
              username = "lars";
          };
      };
      hyprland = {
          enable = true;
      	  nvidia.enable = true;
      };
  };

  services.getty.autologinUser = "lars";
}
