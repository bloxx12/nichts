{
  description = "NixOS presentation";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
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

    pkgsForEach = nixpkgs.legacyPackages;
  in {
    devShells = forEachSystem (system: {
      default = pkgsForEach.${system}.mkShellNoCC {
        packages = [
          (quickshell.packages.${system}.default.override
            {
              withJemalloc = true;
              withQtSvg = true;
              withWayland = true;
              withX11 = false;
              withPipewire = true;
              withPam = true;
              withHyprland = true;
            })
        ];
      };
    });
  };
}
