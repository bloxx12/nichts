{lib, ...}: let
  inherit (lib) mkForce;
in {
  networking.networkmanager = {
    enable = true;
    # Removes about 2GB of stuff we do no need.
    plugins = mkForce [];

    dns = "systemd-resolved";
    unmanaged = [
      # DO NOT manage my docker containers, thank you.
      "interface-name:docker*"
    ];
    wifi = {
      # Generate a randomized value upon each connect
      macAddress = "random";

      # Enable Wi-Fi power saving
      powersave = true;

      # Backend is either wpa_supplicant or iwd,
      # we use wpa_supplicant.
      backend = "wpa_supplicant";
    };
  };
}
