{
  config.fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/3480-C94B";
      fsType = "vfat";
    };

    "/" = {
      device = "/dev/disk/by-uuid/3a781f2e-290a-4609-9035-a93374459def";
      fsType = "ext4";
      options = ["noatime" "compress=zstd"];
    };
  };
}
