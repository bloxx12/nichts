{
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/b51d0f6c-2980-4117-b9df-5cc2c8ddd2d6";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-f1b24c23-8211-433e-983e-2ebad020826e".device = "/dev/disk/by-uuid/f1b24c23-8211-433e-983e-2ebad020826e";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/E355-67EA";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };
}
