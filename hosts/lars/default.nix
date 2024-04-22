{ config, inputs, pkgs, ... }:
{
  imports = [
      ./hyprland.nix
      ./programs.nix
      # ./xwayland.nix
  ];

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
                    y = "yazi";
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
              "keepassxc-browser@keepassxc.org" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/file/4257616/keepassxc_browser-1.9.0.3.xpi";
                installation_mode = "force_installed";
              };
              "{7be2ba16-0f1e-4d93-9ebc-5164397477a9}" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/file/3756025/videospeed-0.6.3.3.xpi";
                installation_mode = "force_installed";
              };
            };
          };

          alacritty = {
            enable = true;
            catppuccin = true;
          };

	  neovim = {
	    enable = true;
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

  # services.flatpak.enable = true;
  services = {
      twingate.enable = true;
      pcscd.enable = true;
  };

  security.pam.yubico = {
   enable = true;
   debug = false;
   mode = "challenge-response";
   id = [ "28067815" "28067816" ];
  };

  # SSH AGENT
  programs.ssh.startAgent = true;
  services.gnome3.gnome-keyring.enable = false;

  system.stateVersion = "23.11";
  nix.settings.experimental-features = ["nix-command" "flakes"];
}
