{ inputs, ... }:
let 
  inherit (inputs) self;
  inherit (self) lib;
in {
  mars = lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit lib inputs self; };
    modules = [
        inputs.stylix.nixosModules.stylix
        ./vali/mars
        ../modules
        inputs.home-manager.nixosModules.home-manager
        inputs.agenix.nixosModules.default
    ];
  };

}
