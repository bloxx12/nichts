{
  withSystem,
  inputs,
  ...
}: let
  inherit (inputs.self) lib;
  inherit (lib.extendedLib.builders) mkSystem;
in {
  flake.nixosConfigurations = {
    temperance = mkSystem {
      inherit withSystem;
      system = "x86_64-linux";
      modules = [
        ./vali/temperance
        ../modules
      ];
    };

    hermit = mkSystem {
      inherit withSystem;
      system = "x86_64-linux";
      modules = [
        ./vali/hermit
        ../modules
      ];
    };
  };
}
