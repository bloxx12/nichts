{
  config = {
    boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/10318654-ed20-43f6-885d-35366a427581";
    fileSystems = {
      "/boot" = {
        device = "/dev/disk/by-uuid/5D7D-FC52";
        fsType = "vfat";
      };

      "/" = {
        device = "/dev/disk/by-uuid/e353013b-8ac7-40ed-80f2-ddbea21b8d5e";
        fsType = "btrfs";
        options = ["compress=zstd" "noatime"];
      };
      "/nix" = {
        device = "/dev/disk/by-uuid/e353013b-8ac7-40ed-80f2-ddbea21b8d5e";
        fsType = "btrfs";
        options = ["subvol=nix" "compress=zstd" "noatime"];
      };
      "/home" = {
        device = "/dev/disk/by-uuid/e353013b-8ac7-40ed-80f2-ddbea21b8d5e";
        fsType = "btrfs";
        options = ["subvol=home" "compress=zstd" "noatime"];
      };
    };
    # swapDevices = [
    #   {
    #     device = "/swap/swapfile";
    #     size = (1024 * 16) + (1024 * 2);
    #   }
    # ];
  };
}
