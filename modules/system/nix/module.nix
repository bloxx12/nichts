{
  pkgs,
  inputs',
  ...
}: {
  imports = [
    ./documentation.nix # nixos documentation
    # ./nixpkgs.nix # global nixpkgs configuration.nix
  ];

  nix = {
    package = inputs'.nix-super.packages.default;

    # Run the Nix daemon on lowest possible priority so that my system
    # stays responsive during demanding tasks such as GC and builds.
    # This is especially useful while auto-gc and auto-upgrade are enabled
    # as they can be quite demanding on the CPU.
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
    daemonIOSchedPriority = 7;

    # Collect garbage
    gc = {
      automatic = true;
      dates = "20:00";
      options = "--delete-older-than 7d";
      persistent = false; # don't try to catch up on missed GC runs
    };

    # Automatically optimize nix store by removing hard links
    # do it after the gc.
    optimise = {
      automatic = true;
      dates = ["21:00"];
    };

    settings = {
      # Tell nix to use the xdg spec for base directories
      # while transitioning, any state must be carried over
      # manually, as Nix won't do it for us.
      use-xdg-base-directories = true;

      # Automatically optimise symlinks
      auto-optimise-store = true;

      # Allow sudo users to mark the following values as trusted
      allowed-users = ["root" "@wheel" "nix-builder"];

      # Only allow sudo users to manage the nix store
      trusted-users = ["root" "@wheel" "nix-builder"];

      # Let the system decide the number of max jobs
      # based on available system specs. Usually this is
      # the same as the number of cores your CPU has.
      max-jobs = "auto";

      # Always build inside sandboxed environments
      sandbox = true;
      sandbox-fallback = false;

      # Continue building derivations even if one fails
      keep-going = true;

      # Fallback to local builds after remote builders are unavailable.
      # Setting this too low on a slow network may cause remote builders
      # to be discarded before a connection can be established.
      connect-timeout = 5;

      # If we haven't received data for >= 20s, retry the download
      stalled-download-timeout = 20;

      # Show more logs when a build fails and decides to display
      # a bunch of lines. `nix log` would normally provide more
      # information, but this may save us some time and keystrokes.
      log-lines = 30;

      # Extra features of Nix that are considered unstable
      # and experimental. By default we should always include
      # `flakes` and `nix-command`, while others are usually
      # optional.
      extra-experimental-features = [
        "flakes" # flakes
        "nix-command" # experimental nix commands
        "cgroups" # allow nix to execute builds inside cgroups
      ];

      # Ensures that the result of Nix expressions is fully determined by
      # explicitly declared inputs, and not influenced by external state.
      # In other words, fully stateless evaluation by Nix at all times.
      pure-eval = true;

      # Don't warn me that my git tree is dirty, I know.
      warn-dirty = false;

      # Maximum number of parallel TCP connections
      # used to fetch imports and binary caches.
      # 0 means no limit, default is 25.
      http-connections = 50; # lower values fare better on slow connections

      # Whether to accept nix configuration from a flake
      # without displaying a Y/N prompt. For those obtuse
      # enough to keep this true, I wish the best of luck.
      # tl;dr: this is a security vulnerability.
      accept-flake-config = false;

      # Whether to execute builds inside cgroups. cgroups are
      # "a Linux kernel feature that limits, accounts for, and
      # isolates the resource usage (CPU, memory, disk I/O, etc.)
      # of a collection of processes."
      # See:
      # <https://en.wikipedia.org/wiki/Cgroups>
      use-cgroups = pkgs.stdenv.isLinux; # only supported on Linux

      # for direnv GC roots
      keep-derivations = true;
      keep-outputs = true;

      # Use binary cache, this is not Gentoo
      # external builders can also pick up those substituters
      builders-use-substitutes = true;

      # Substituters to pull from. While sigs are disabled, we must
      # make sure the substituters listed here are trusted.
      substituters = [
        "https://cache.nixos.org" # funny binary cache
        "https://cache.privatevoid.net" # for nix-super
        "https://nix-community.cachix.org" # nix-community cache
        "https://hyprland.cachix.org" # hyprland
        "https://nixpkgs-unfree.cachix.org" # unfree-package cache
        "https://anyrun.cachix.org" # anyrun program launcher
        "https://neovim-flake.cachix.org" # a cache for my neovim flake
        "https://cache.garnix.io" # garnix binary cache, hosts prismlauncher
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "cache.privatevoid.net:SErQ8bvNWANeAvtsOESUwVYr2VJynfuc9JRwlzTTkVg="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
        "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      ];
    };
  };

  # By default nix-gc makes no effort to respect battery life by avoiding
  # GC runs on battery and fully commits a few cores to collecting garbage.
  # This will drain the battery faster than you can say "Nix, what the hell?"
  # and contribute heavily to you wanting to get a new desktop.
  # For those curious (such as myself) desktops are always seen as "AC powered"
  # so the system will not fail to fire if you are on a desktop system.
  systemd.services.nix-gc = {
    unitConfig.ConditionACPower = true;
  };
}
