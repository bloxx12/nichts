{ config, inputs, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  time.timeZone = "Europe/Zurich";
  security.sudo.package = pkgs.sudo.override { withInsults = true; };
  security.polkit.enable = true;
  programs.kdeconnect.enable = true;
  myOptions = {
      other = {
          home-manager = {
              enable = true;
              enableDirenv = true;
          };
      };

      programs = {
          vesktop.enable = true;
          btop.enable = true;
          mpv.enable = true;
          schizofox.enable = true;

          zsh = {
              enable = true;
              profiling = false;
	            extraAliases = {
	                cls = "clear"; 

  	          };
          };

	  git = {
	      enable = true;
	      userName = "LarsZauberer";
	      userEmail = "wasser.ian@gmail.com";
	      defaultBranch = "main";
	  };
      };

      services = {
          pipewire.enable = true;
        };

      themes = {
          cursor = {
              enable = false;
              package = pkgs.bibata-cursors;
              name = "Bibata-Modern-Classic";
              size = 24;
          };
          gtk = {
              enable = false;
              package = pkgs.catppuccin-gtk;
              name = "Catppuccin-Mocha-Standard-Green-Dark";
              variant = "mocha";
              accentColour = "green";
              iconTheme = {
                  name = "Papirus-Dark";
                  package = pkgs.catppuccin-papirus-folders;
              };
          };
          qt = {
            enable = false;
            package = pkgs.catppuccin-kde;
            name = "Catppuccin-Mocha-Dark";
            variant = "mocha";
            accentColour = "green";
          };
      };
    };

  console.keyMap = "sg"; 

  system.stateVersion = "23.11";
}
