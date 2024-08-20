{
  pkgs,
  config,
  ...
}: {
  # Time Zone
  time.timeZone = "Europe/Zurich";
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "de";
  security.sudo.package = pkgs.sudo.override {withInsults = true;};
  security.polkit.enable = true;
  programs.kdeconnect.enable = true;
  programs.dconf.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  modules = {
    system = {
      hardware = {
        bluetooth = {
          enable = true;
          powerOnBoot = false;
        };
      };
      programs = {
        editors = {
          emacs.enable = true;
          neovim.enable = true;
          helix.enable = false;
          kakoune.enable = false;
        };
        discord.enable = true;
        firefox.enable = true;
        spotify.enable = true;
        zellij.enable = true;
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
        hostname = "hermit";
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
      waybar.enable = true;
    };
    services = {
      dunst.enable = true;
    };
    theming = {
      quickshell.enable = true;
    };
  };
  system.stateVersion = "23.11";
}
