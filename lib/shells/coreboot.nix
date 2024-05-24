let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-23.11";

  pkgs = import nixpkgs {
    config = {};
    overlays = [];
  };
in
  pkgs.mkShellNoCC {
    packages = with pkgs; [
      m4
      bison
      ncurses
      gcc
      clang
      gnat
      zlib
      flex
      pkg-config
      curl
      zlib
      coreboot-toolchain.x64
    ];

    GREETING = "You're now in the coreboot build shell!;";
    shellHook = ''cd /home/vali/repos/coreboot && echo $GREETING'';
  }
