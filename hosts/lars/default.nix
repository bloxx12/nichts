{ config, inputs, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  time.timeZone = "Europe/Zurich";
  security.sudo.package = pkgs.sudo.override { withInsults = true; };
  security.polkit.enable = true;
  programs.kdeconnect.enable = true;
  modules = {
      other = {
          system = {
              gitPath = "/home/lars/nichts";
	  };
          home-manager = {
              enable = true;
              enableDirenv = true;
          };
      };

      waybar.enable = true;

      programs = {
          vesktop.enable = true;
          btop.enable = true;
          mpv.enable = true;
          yazi.enable = true;

          zsh = {
              enable = true;
              profiling = false;
	            extraAliases = {
	                cls = "clear"; 
                  Hyprland = "dbus-run-session Hyprland";
  	          };
	      ohmyzsh = {
	          enable = true;
		        theme = "fino-time";
	        };
        };

	  git = {
	      enable = true;
	      userName = "LarsZauberer";
	      userEmail = "wasser.ian@gmail.com";
	      defaultBranch = "main";
	  };

          firefox = {
            enable = true;
            extensions = {
              "support@lastpass.com" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/file/4246455/lastpass_password_manager-4.127.0.1.xpi";
                installation_mode = "force_installed";
              };
              "newtaboverride@agenedia.com" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/file/4231522/new_tab_override-16.0.0.xpi";
                installation_mode = "force_installed";
              };
            };
          };

          alacritty = {
            enable = true;
            catppuccin = true;
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
              enable = true;
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
            enable = true;
            package = pkgs.catppuccin-kde;
            name = "Catppuccin-Mocha-Dark";
            variant = "mocha";
            accentColour = "green";
          };
      };
    };

  console.keyMap = "sg"; 

  system.stateVersion = "23.11";
  nix.settings.experimental-features = ["nix-command" "flakes"];
}
