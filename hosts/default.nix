{inputs, ...}: let
  inherit (inputs) self;
  inherit (self) lib;
in {
  temperance = lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit lib inputs self;};
    modules = [
      ./vali/temperance
      ../modules
      inputs.home-manager.nixosModules.home-manager
      inputs.agenix.nixosModules.default
      inputs.stylix.nixosModules.stylix
    ];
  };
  hermit = lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit lib inputs self;};
    modules = [
      ./vali/hermit
      ../modules
      inputs.home-manager.nixosModules.home-manager
      inputs.agenix.nixosModules.default
      inputs.stylix.nixosModules.stylix
    ];
  };
}
