{ inputs, ... }:
let 
  inherit (inputs) self;
  inherit (self) lib;
in {
  vali = lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit lib inputs self; };
  };
  modules = [
      ./vali
      ../modules
      inputs.home-manager.nixosModules.home-manager
      inputs.agenix.nixosModules.default
  ];
}
