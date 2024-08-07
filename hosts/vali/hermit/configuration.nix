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
      trusted-users = ["root" "${config.modules.other.system.username}"];
      # enable flakes
      experimental-features = ["nix-command" "flakes"];
      # reduce file size used & automatic garbage collector
      auto-optimise-store = true;
      max-jobs = 3;
      cores = 4;
    };
  };
  security.sudo.package = pkgs.sudo.override {withInsults = true;};
  security.polkit.enable = true;
  programs.kdeconnect.enable = true;
  programs.dconf.enable = true;
  services.thermald.enable = true;
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "auto";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  modules = {
    other = {
      system = {
        hostname = "hermit";
        username = "vali";
        gitPath = "/home/vali/repos/nichts";
      };
      home-manager = {
        enable = true;
        enableDirenv = true;
      };
    };
    wms = {
      wayland = {
        enable = true;
        hyprland.enable = true;
      };
    };
    system = {
      programs = {
        discord.enable = true;
        firefox.enable = true;
        zathura.enable = true;
        terminals = {
          foot.enable = true;
          kitty.enable = true;
        };
      };
    };
    usrEnv = {
      programs = {
        launchers = {
          anyrun.enable = true;
        };
      };
      services = {
        mpd.enable = true;
      };
    };
    programs = {
      vesktop.enable = true;
      ssh.enable = true;
      btop.enable = true;
      mpv.enable = true;
      newsboat.enable = true;
      fish.enable = true;
      ncmpcpp.enable = true;
      nh.enable = true;
      waybar.enable = true;
      beets.enable = true;
    };
    editors = {
      emacs.enable = false;
      helix.enable = true;
      kakoune.enable = false;
      neovim.enable = false;
    };
    services = {
      pipewire.enable = true;
      dunst.enable = true;
      mpd = {
        enable = true;
        musicDirectory = "/home/${config.modules.other.system.username}/Nextcloud/Media/Music";
      };
    };
    theming = {
      quickshell.enable = true;
      stylix = {
        # FIXME: Broken
        enable = true;
        #        scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-pale.yaml";
        scheme = "${pkgs.base16-schemes}/share/themes/tomorrow-night.yaml";
        cursor = {size = 28;};
        fontsizes = {
          terminal = 18;
          popups = 14;
          applications = 14;
        };
        image = ../../../assets/wallpapers/tiredgod.png;
      };
      gtk = {enable = false;};
      qt = {
        enable = true;
        package = pkgs.kde-gruvbox;
        name = "Gruvbox-Dark";
      };
    };
  };
  system.stateVersion = "23.11";
}
