{
  config = {
    boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/70952ef8-1d73-49ae-bd86-b7614f01fa86";
    fileSystems = {
      "/boot" = {
        device = "/dev/disk/by-uuid/466A-F45E";
        fsType = "vfat";
      };
      # root on tmpfs
      "/" = {
        device = "none";
        fsType = "tmpfs";
        options = ["defaults" "size=25%" "mode=755"];
      };
      "/nix" = {
        device = "/dev/disk/by-uuid/7fd4eb96-c9e6-450d-a7d6-1b2ef137a9f5";
        fsType = "btrfs";
        options = ["subvol=nix" "compress=zstd" "noatime"];
      };
      "/persist" = {
        device = "/dev/disk/by-uuid/7fd4eb96-c9e6-450d-a7d6-1b2ef137a9f5";
        neededForBoot = true;
        fsType = "btrfs";
        options = ["subvol=persist" "compress=zstd" "noatime"];
      };
      "/home" = {
        device = "/dev/disk/by-uuid/7fd4eb96-c9e6-450d-a7d6-1b2ef137a9f5";
        fsType = "btrfs";
        options = ["subvol=home" "compress=zstd" "noatime"];
      };
      "/swap" = {
        device = "/dev/disk/by-uuid/7fd4eb96-c9e6-450d-a7d6-1b2ef137a9f5";
        fsType = "btrfs";

        options = ["subvol=swap" "compress=lzo" "noatime"];
      };
    };
    swapDevices = [
      {
        device = "/swap/swapfile";
        size = (1024 * 16) + (1024 * 2);
      }
    ];
  };
}
