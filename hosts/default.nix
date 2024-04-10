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
      ../modules/vali
      inputs.home-manager.noxosModules.home-manager
      inputs.agenix.noxosModules.default
  ];
}
