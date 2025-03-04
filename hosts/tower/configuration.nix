{
  lib,
  pkgs,
  ...
}: {
  # Time Zone
  time.timeZone = "Europe/Vienna";
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "uk";
  security.polkit.enable = true;

  # boot.kernelPackages = pkgs.linuxPackagesFor xanmod_blox;
  # boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  programs.nix-ld.enable = true;
  users.users."cr".openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILPiRe9OH/VtWFWyy5QbAVcN7CLxr4zUtRCwmxD6aeN6"
    "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAAWEDj/Yib6Mqs016jx7rtecWpytwfVl28eoHtPYCM9TVLq81VIHJSN37lbkc/JjiXCdIJy2Ta3A3CVV5k3Z37NbgAu23oKA2OcHQNaRTLtqWlcBf9fk9suOkP1A3NzAqzivFpBnZm3ytaXwU8LBJqxOtNqZcFVruO6fZxJtg2uE34mAw=="
  ];
  services = {
    fstrim.enable = lib.mkDefault true;
  };

  meta = {
    mainUser.gitSigningKey = "";
  };
  modules = {
    system = {
      programs = {
        editors = {
          helix.enable = true;
        };
        eza.enable = true;
      };
    };
    usrEnv = {
      desktops.hyprland.enable = false;

      services = {
        locate.enable = true;
      };
    };
    other = {
      system = {
        username = "cr";
      };
    };
    programs = {
      ssh.enable = true;
      btop.enable = true;
      nh.enable = true;
    };
    # style.colorScheme.name = "Black Metal Venom";
  };
}
