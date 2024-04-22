{ config, inputs, pkgs, ... }:
{
  modules = {
      other = {
          system = {
              hostname = "kronos";
              username = "lars";
          };
      };

      programs = {
        alacritty = {
          opacity = 0.8;
          blur = true;
        };

        steam = {
            enable = true;
            gamescope = true;
        };
      };

      hyprland = {
          enable = true;
      	  nvidia.enable = true;
			monitor = [
			    "DP-2,2560x1440@144,0x0,1"
			    "DP-1,1920x1080@60,2560x0,1"
			];
          extra = {
            exec-once = [
              "hyprctl dispatch moveworkspacetomonitor 1 DP-2"
            ];
          };
          wallpaper = "wallpaper/wave.jpg";
      };
  };

  services.getty.autologinUser = "lars";
  services.flatpak.enable = true;
}
