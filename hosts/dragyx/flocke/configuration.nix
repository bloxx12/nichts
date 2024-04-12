{ config, pkgs, ... }:

{
  imports = [
    ../../../options/common/pin-registry.nix
    ../../../options/common/preserve-system.nix
    ../../../options/desktop/fonts.nix
  ];


  nixpkgs.config.allowUnfree = true;
  time.timeZone = "Europe/Zurich";
  security.sudo.package = pkgs.sudo.override { withInsults = true; };

  services.xserver = {
    enable = true;
    displayManager = {
      sessionPackages = [ pkgs.hyprland ]; # pkgs.gnome.gnome-session.sessions ];
      defaultSession = "hyprland";
      sddm = {
        enable = true;
      };
    };
    windowManager.hypr.enable = true;
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

  modules = {
    other = {
      system = {
          hostname = "flocke";
          username = "dragyx";
          monitors = {
            name = "LaptopMain";
            resolution = {
              x = 2256;
              y = 1504;
            };
            scale = 1.0;
            refresh_rate = 60;
          };
      };
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
        obs.enable = true;
        neovim.enable = true;
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
        # badneovim.enable = true;
    };
    services = {
        pipewire.enable = true;
    };
    WM.hyprland.enable = true;
  };
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}
