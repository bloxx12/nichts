{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf mkMerge;

  sys = config.modules.system;
in {
  config = mkMerge [
    (mkIf (builtins.elem "btrfs" sys.fs) {
      # scrub btrfs devices
      services.btrfs.autoScrub = {
        enable = true;
        fileSystems = ["/"];
      };

      # this fixes initrd.systemd.enable for whatever reason
      boot = {
        supportedFilesystems = ["btrfs"];
        initrd = {
          supportedFilesystems = ["btrfs"];
        };
      };
    })

    (mkIf (builtins.elem "ext4" sys.fs) {
      boot = {
        supportedFilesystems = ["ext4"];
        initrd = {
          supportedFilesystems = ["ext4"];
        };
      };
    })

    (mkIf (builtins.elem "exfat" sys.fs) {
      boot = {
        supportedFilesystems = ["exfat"];
        initrd = {
          supportedFilesystems = ["exfat"];
        };
      };
    })

    # accept both ntfs and ntfs3 as valid values
    (mkIf ((builtins.elem "ntfs" sys.fs) || (builtins.elem "ntfs3" sys.fs)) {
      boot = {
        supportedFilesystems = ["ntfs"];
      };
    })
  ];
}
