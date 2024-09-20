{
  config = {
    boot.initrd.luks.devices."cryptroot".device = "/dev/disk-by-uuid/";
    fileSystems = {
      "/boot" = {
        device = "";
        fsType = "vfat";
      };
      # root on tmpfs
      "/" = {
        device = "none";
        fsType = "tmpfs";
        options = ["defaults" "size=25%" "mode=755"];
      };
      "/nix" = {
        device = "";
        fsType = "btrfs";
        options = ["subvol=nix" "compress=zstd" "noatime"];
      };
      "/persist" = {
        device = "";
        neededForBoot = true;
        fsType = "btrfs";
        options = ["subvol=persist" "compress=zstd" "noatime"];
      };
      "/home" = {
        device = "";
        fsType = "btrfs";
        options = ["subvol=home" "compress=zstd" "noatime"];
      };
      "/swap" = {
        device = "";
        fsType = "btrfs";

        options = ["subvol=swap" "compress=lzo" "noatime"];
      };
    };
    swapDevices = [
      {device = "";}
    ];
  };
}