_: {
  imports = [
    ./keyboard.nix
    ./boot
    ./hardware
    ./nix/module.nix
    ./os/networking/module.nix
    ./os/security/module.nix
  ];
}
