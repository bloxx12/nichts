{
  pkgs,
  config,
  ...
}: {
  # allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # Time Zone
  time.timeZone = "Europe/Zurich";
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "de";
  nix = {
    settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
      # enable flakes
      # reduce file size used & automatic garbage collector
    };
  };
  security.sudo.package = pkgs.sudo.override {withInsults = true;};
  security.polkit.enable = true;
  programs.kdeconnect.enable = true;
  programs.dconf.enable = true;
  virtualisation.docker.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  modules = {
    system = {
      programs = {
        editors = {
          emacs.enable = true;
          neovim.enable = true;
          helix.enable = true;
          kakoune.enable = true;
        };
        discord.enable = true;
        firefox.enable = true;
        zathura.enable = true;
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
          anyrun.enable = true;
          rofi.enable = true;
        };
        media = {
          beets.enable = true;
          mpv.enable = true;
          ncmpcpp.enable = true;
        };
      };
      services = {
        locate.enable = true;
        wpaperd.enable = true;
        media.mpd = {
          enable = true;
          musicDirectory = "/home/${config.modules.other.system.username}/Nextcloud/Media/Music";
        };
      };
      style = {
        stylix = {
          enable = true;
          scheme = "${pkgs.base16-schemes}/share/themes/tomorrow-night.yaml";
          cursor = {
            size = 28;
            package = pkgs.bibata-cursors;
            name = "Bibata-Modern-Classic";
          };
          fontsizes = {
            terminal = 18;
            popups = 14;
            applications = 14;
          };
          image = ../../../assets/wallpapers/tiredgod.png;
        };
      };
    };
    other = {
      system = {
        hostname = "temperance";
        username = "vali";
        gitPath = "/home/vali/projects/nichts";
      };
      home-manager = {
        enable = true;
        enableDirenv = true;
      };
    };
    programs = {
      ssh.enable = true;
      btop.enable = true;
      newsboat.enable = true;
      fish.enable = true;
      nh.enable = true;
      steam.enable = true;
      waybar.enable = true;
    };
    services = {
      dunst.enable = true;
    };
    theming = {
      quickshell.enable = true;
      gtk.enable = true;
      qt = {
        enable = false;
        package = pkgs.kde-gruvbox;
        name = "Gruvbox-Dark";
      };
    };
  };
  system.stateVersion = "23.11";
}
