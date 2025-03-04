{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.meta) getExe;
in {
  systemd.user.services.wayneko = {
    description = "Wayneko, as a systemd service";

    wantedBy = ["graphical-session.target"];
    partOf = ["graphical-session.target"];
    after = ["graphical-session.target"];

    serviceConfig = {
      ExecStart = "${getExe pkgs.wayneko} --layer top";

      LockPersonality = true;
      MemoryDenyWriteExecute = true;
      NoNewPrivileges = true;

      PrivateTmp = true;
      PrivateDevices = true;
      DevicePolicy = "closed";
      PrivateNetwork = true;
      ProtectClock = true;
      ProtectControlGroups = true;
      ProtectControlGroup = true;
      ProtectKernelLogs = true;
      ProtectKernelModules = true;
      ProtectKernelTunables = true;
      ProtectSystem = "strict";
      ProtectHome = "read-only";

      RestrictNamespaces = true;
      RestrictRealtime = true;
      RestrictRealTime = true;
      RestrictSUIDSGID = true;

      SystemCallFilter = "~@clock @cpu-emulation @debug @obsolete @module @mount @raw-io @reboot @swap";
    };
  };
}
