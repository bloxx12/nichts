{
  config = {
    boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/96e8f3d6-8d2d-4e2d-abd9-3eb7f48fed02";
    fileSystems = {
      "/boot" = {
        device = "7825-451F";
        fsType = "vfat";
      };
      # root on tmpfs
      "/" = {
        device = "none";
        fsType = "tmpfs";
        options = ["defaults" "size=25%" "mode=755"];
      };
      "/nix" = {
        device = "/dev/disk/by-uuid/f0569993-722e-4721-b0d9-8ac537a7a548";
        fsType = "btrfs";
        options = ["subvol=nix" "compress=zstd" "noatime"];
      };
      "/persist" = {
        device = "/dev/disk/by-uuid/f0569993-722e-4721-b0d9-8ac537a7a548";
        neededForBoot = true;
        fsType = "btrfs";
        options = ["subvol=persist" "compress=zstd" "noatime"];
      };
      "/home" = {

        device = "/dev/disk/by-uuid/f0569993-722e-4721-b0d9-8ac537a7a548";
        fsType = "btrfs";
        options = ["subvol=home" "compress=zstd" "noatime"];
      };
      "/swap" = {
        device = "/dev/disk/by-uuid/f0569993-722e-4721-b0d9-8ac537a7a548";
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
