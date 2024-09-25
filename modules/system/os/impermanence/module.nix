{
  inputs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkForce;
  inherit (builtins) map;

  cfg = config.modules.system.impermanence;
in {
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];
  users = {
    mutableUsers = false;
    users = {
      cr = {
        hashedPasswordFile = "/persist/passwords/cr";
      };
      root.hashedPasswordFile = "/persist/passwords/root";
    };
  };

  environment.persistence."/persist" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/etc/nixos"
      "/etc/nix"
      "/etc/NetworkManager/system-connections"
      "/var/db/sudo"
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/pipewire"
      "/var/lib/systemd/coredump"
    ];

    files = [
      "/etc/machine-id"
    ];
    users.cr = {
      directories =
        [
          "cloud"
          "repos"
        ]
        ++ map (
          dir: ".config/${dir}"
        ) ["nicotine" "Signal" "Nextcloud" "emacs" "doom"]
        ++ map (
          dir: ".cache/${dir}"
        ) ["tealdeer" "keepassxc" "nix" "starship" "nix-index" "mozilla" "zsh" "nvim"]
        ++ map (
          dir: ".local/share/${dir}"
        ) ["direnv" "Steam" "TelegramDesktop" "PrismLauncher" "nicotine" "zoxide" ".ssh" ".keepass"];
    };
  };

  # for some reason *this* is what makes networkmanager not get screwed completely instead of the impermanence module
  systemd.tmpfiles.rules = [
    "L /var/lib/NetworkManager/secret_key - - - - /persist/var/lib/NetworkManager/secret_key"
    "L /var/lib/NetworkManager/seen-bssids - - - - /persist/var/lib/NetworkManager/seen-bssids"
    "L /var/lib/NetworkManager/timestamps - - - - /persist/var/lib/NetworkManager/timestamps"
  ];

  services.openssh.hostKeys = mkForce [
    {
      bits = 4096;
      path = "/persist/etc/ssh/ssh_host_rsa_key";
      type = "rsa";
    }
    {
      bits = 4096;
      path = "/persist/etc/ssh/ssh_host_ed25519_key";
      type = "ed25519";
    }
  ];
}
