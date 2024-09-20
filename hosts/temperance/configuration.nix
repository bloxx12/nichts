{
  config,
  lib,
  pkgs,
  ...
}: {
  # Time Zone
  time.timeZone = "Europe/Zurich";
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "de";
  security.polkit.enable = true;
  programs.kdeconnect.enable = true;
  programs.nix-ld.enable = false;
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  services = {
    fstrim.enable = lib.mkDefault true;
  };

  modules = {
    system = {
      programs = {
        editors = {
          emacs.enable = true;
          # only emacs for me, right now.
          neovim.enable = true;
          # sadly just not advanced enough, yet.
          helix.enable = true;
          kakoune.enable = false;
        };
        discord.enable = true;
        nushell.enable = true;
        oh-my-posh.enable = true;
        eza.enable = true;
        firefox.enable = true;
        spotify.enable = true;
        zellij.enable = true;
        steam.enable = true;
        terminals = {
          foot.enable = true;
          kitty.enable = true;
        };
      };
      sound.enable = true;
    };
    usrEnv = {
      desktops.hyprland.enable = true;

      programs = {
        launchers = {
          fuzzel.enable = true;
        };

        media = {
          beets.enable = true;
          mpv.enable = true;
          ncmpcpp.enable = true;
        };
      };
      services = {
        locate.enable = true;

        media.mpd = {
          enable = true;
          musicDirectory = "/home/${config.modules.other.system.username}/Nextcloud/media/Music";
        };
      };

      style = {
        gtk.enable = true;
        qt.enable = true;
      };
    };
    other = {
      system = {
        hostname = "temperance";
        username = "cr";
      };

      home-manager = {
        enable = true;
      };
    };
    programs = {
      ssh.enable = true;
      btop.enable = true;
      newsboat.enable = true;
      # fish.enable = true;
      nh.enable = true;
      waybar.enable = true;
      # steam.enable = true;
    };

    services = {
      dunst.enable = true;
    };
  };
  system.stateVersion = "23.11";
}
