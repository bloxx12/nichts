{
  lib,
  pkgs,
  ...
}: {
  # Time Zone
  time.timeZone = "Europe/Zurich";
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "uk";
  security.polkit.enable = true;
  programs.kdeconnect.enable = true;
  programs.nix-ld.enable = false;
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  services = {
    fstrim.enable = lib.mkDefault true;
    thermald.enable = true;
    auto-cpufreq.enable = true;
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };

  modules = {
    system = {
      impermanence.enable = false;
      hardware = {
        nvidia.enable = true;
        bluetooth = {
          enable = true;
          powerOnBoot = false;
        };
      };
      programs = {
        editors = {
          emacs.enable = false;
          # only emacs for me, right now.
          neovim.enable = true;
          # sadly just not advanced enough, yet.
          helix.enable = true;
        };
        discord.enable = true;
        # nushell.enable = true;
        eza.enable = true;
        firefox.enable = true;
        spotify.enable = false;
        # starship.enable = true;
        zellij.enable = true;
        terminals = {
          foot.enable = true;
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
        };
      };

      style = {
        gtk.enable = true;
        qt.enable = true;
      };
    };
    other = {
      system.username = "cr";
    };
    programs = {
      ssh.enable = true;
      btop.enable = true;
      nh.enable = true;
    };
  };
  system.stateVersion = "23.11";
}
