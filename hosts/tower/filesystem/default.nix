{
  config = {
    fileSystems = {
      "/boot" = {
        device = "/dev/disk/by-uuid/3480-C94B";
        fsType = "vfat";
      };
      # root on tmpfs
      "/" = {
        device = "/dev/disk/by-uuid/3dde50ca-440d-4d46-974e-efc623e53703";
        fsType = "btrfs";
        options = ["compress=zstd" "noatime"];
      };
    };
  };
}
