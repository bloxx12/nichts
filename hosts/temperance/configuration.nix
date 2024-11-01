{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit
    (
      pkgs.callPackage ./kernel/xanmod.nix {
        inherit lib;
        inherit
          (pkgs)
          stdenv
          fetchFromGitHub
          kernelPatches
          buildLinux
          variant
          ;
      }
    )
    xanmod_blox
    ;
in {
  # Time Zone
  time.timeZone = "Europe/Zurich";
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "de";
  security.polkit.enable = true;

  # boot.kernelPackages = pkgs.linuxPackagesFor xanmod_blox;
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  programs.nix-ld.enable = true;
  services = {
    fstrim.enable = lib.mkDefault true;
  };

  meta = {
    mainUser.gitSigningKey = "";
  };
  modules = {
    system = {
      impermanence.enable = true;
      programs = {
        editors = {
          emacs.enable = true;
          # only emacs for me, right now.
          neovim.enable = true;
          # sadly just not advanced enough, yet.
          helix.enable = true;
          kakoune.enable = true;
        };
        discord.enable = true;
        nushell.enable = true;
        oh-my-posh.enable = true;
        eza.enable = true;
        firefox.enable = true;
        spotify.enable = true;
        zellij.enable = false;
        steam.enable = true;
        terminals = {
          foot.enable = true;
          kitty.enable = true;
        };
      };
      sound.enable = true;
      hardware.nvidia.enable = true;
    };
    # style.colorScheme.name = "Zenburn";
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
        kmscon.enable = false;
        greetd.enable = true;

        media.mpd = {
          enable = true;
          musicDirectory = "/home/${config.modules.other.system.username}/cloud/media/Music";
        };
      };

      style = {
        gtk.enable = true;
        qt.enable = true;
      };
    };
    other = {
      system = {
        username = "cr";
      };

      home-manager = {
        enable = true;
      };
    };
    programs = {
      ssh.enable = true;
      btop.enable = true;
      fish.enable = true;
      nh.enable = true;
      waybar.enable = true;
      # steam.enable = true;
    };

    services = {
      dunst.enable = true;
    };
  };
}
