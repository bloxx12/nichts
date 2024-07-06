	# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/b51d0f6c-2980-4117-b9df-5cc2c8ddd2d6";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-f1b24c23-8211-433e-983e-2ebad020826e".device = "/dev/disk/by-uuid/f1b24c23-8211-433e-983e-2ebad020826e";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/E355-67EA";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
#  swapDevices =
#    [ { device = "/dev/disk/by-uuid/3518272e-1051-41e2-a7f0-f5c744e46789"; }
#    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp59s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
