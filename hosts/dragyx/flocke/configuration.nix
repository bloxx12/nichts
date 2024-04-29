{ config, pkgs, ... }:

{
  imports = [
    ../common/default.nix
    ./packages.nix
  ];


  nixpkgs.config.allowUnfree = true;
  time.timeZone = "Europe/Zurich";
  security.sudo.package = pkgs.sudo.override { withInsults = true; };

  services.displayManager = {
      sessionPackages = [ pkgs.hyprland ]; # pkgs.gnome.gnome-session.sessions ];
      defaultSession = "hyprland";
      sddm = {
        enable = true;
        wayland.enable = true;
    };
  };


  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.enable = true;

  services.logrotate.checkConfig = false;

  networking.hostName = "flocke"; # Define your hostname.
  networking.hostId = "adf23c31";
  networking.interfaces.wlp1s0.useDHCP = true;
  networking.networkmanager.enable = true;
  environment.systemPackages = with pkgs; [ networkmanager ]; # cli tool for managing connections

  boot = {
    kernelParams = [ ];
    initrd.supportedFilesystems = [ "ext4" ];
    supportedFilesystems = [ "ext4" ];
    loader = {
      efi.efiSysMountPoint = "/boot";
      efi.canTouchEfiVariables = true;
      grub = {
          enable = true;
          device = "nodev";
          efiSupport = true;
          enableCryptodisk = true;
          useOSProber = true;
          extraEntries = ''
            menuentry "Reboot" {
              reboot
            }
            menuentry "Poweroff" {
              halt
            }
          '';
        };
    };
    initrd.luks.devices = {
        cryptroot = {
          device = "/dev/disk/by-uuid/ec5ff3a1-9b39-4ba5-aa0f-19e898b4f6e8";
          preLVM = true;
        };
    };
  };

  # see https://nixos.wiki/wiki/AMD_GPU
  services.xserver.videoDrivers = [ "amdgpu" ];
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];
  hardware.opengl.extraPackages =  with pkgs; [
    rocmPackages.clr.icd
  ];

  services.power-profiles-daemon.enable = false;

  # stock nixos power management
  powerManagement.enable = true;

  services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;

       #Optional helps save long term battery health
       START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
       STOP_CHARGE_THRESH_BAT0 = 85; # 80 and above it stops charging

      };
};

 swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 32*1024;
  } ];


  # be nice to your ssds
  services.fstrim.enable = true;
  # services.xserver.enable = pkgs.lib.mkForce false;

  security.polkit.enable = true;
  home-manager.users."dragyx".home.packages = with pkgs; [ vesktop ];

  # Mainly for coding weekend
  services.hardware.bolt.enable = true;

  modules = {
    other = {
      system = rec {
          hostname = "flocke";
          username = "dragyx";
          gitPath = "/home/${username}/repos/nichts";
          monitors = [
            {
              name = "LaptopMain";
              device = "eDP-1";
              resolution = {
                x = 2256;
                y = 1504;
              };
              scale = 1.175;
              refresh_rate = 60;
              position = {
                x = 0;
                y = 0;
              };
            }
            rec {
              name = "CodingWeekend";
              device = "DP-9";
              resolution = {
                x = 2560;
                y = 1440;
              };
              refresh_rate = 60;
              scale = 1;
              position = {
                x = -152;
                y = -resolution.y;
              };
            }
            rec {
              name = "CodingWeekend2";
              device = "DP-10";
              resolution = {
                x = 2560;
                y = 1440;
              };
              refresh_rate = 60;
              scale = 1;
              position = {
                x = -152;
                y = -resolution.y;
              };
            }
          ];
          wayland = true;
      };
      home-manager = {
          enable = true;
          enableDirenv = true;
      };
    };
    programs = {
        vesktop.enable = false;
        btop.enable = true;
        mpv.enable = true;
        schizofox.enable = false;
        obs.enable = true;
        vivado.enable = true;
        rofi.enable = true;
        zathura.enable = true;
        # neovim.enable = true;
        git = {
            enable = true;
            userName = "Dragyx";
            userEmail = "66752602+Dragyx@users.noreply.github.com";
            defaultBranch = "main";
        };
        starship.enable = true;
        zsh = {
            enable = true;
            profiling = false;
        };
        neovim-old.enable = true;
    };
    services = {
        pipewire.enable = true;
    };
    WM.hyprland.enable = true;
    WM.hyprland.gnome-keyring = true;
  };
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}
