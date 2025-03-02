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
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  programs.nix-ld.enable = true;
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
