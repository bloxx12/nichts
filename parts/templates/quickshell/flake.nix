{
  description = "Quickshell tinkering";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    quickshell,
    ...
  }: let
    systems = ["x86_64-linux" "aarch64-linux"];
    forEachSystem = nixpkgs.lib.genAttrs systems;
  in {
    devShells = forEachSystem (system: {
      default = nixpkgs.legacyPackages.${system}.mkShell {
        packages = with nixpkgs.legacyPackages.${system}; [
          (
            quickshell.packages.${system}.default.override
            {
              withJemalloc = false;
              withQtSvg = false;
              withWayland = true;
              withX11 = false;
              withPipewire = true;
              withPam = false;
              withHyprland = false;
            }
          )
          # dependencies
          cli11
          cmake
          jemalloc
          kdePackages.wayland
          wayland
          wayland-protocols
          wayland-scanner
          pkg-config
          pipewire
          qt6Packages.qtbase
          qt6.qtdeclarative
        ];
      };
    });
  };
}
