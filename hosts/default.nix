{inputs, ...}: let
  inherit (inputs) self;
  inherit (self) lib;
in {
  temperance = lib.nixosSystem rec {
    system = "x86_64-linux";
    specialArgs = {inherit lib inputs self system;};
    modules = [
      ./vali/temperance
      ../modules
      inputs.home-manager.nixosModules.home-manager
      inputs.agenix.nixosModules.default
    ];
  };
  hermit = lib.nixosSystem rec {
    system = "x86_64-linux";
    specialArgs = {inherit lib inputs self system;};
    modules = [
      ./vali/hermit
      ../modules
      inputs.home-manager.nixosModules.home-manager
      inputs.agenix.nixosModules.default
      inputs.lix-module.nixosModules.default
      inputs.nixos-hardware.nixosModules.dell-xps-15-7590-nvidia
    ];
  };
}
