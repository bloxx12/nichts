{ config, pkgs, inputs, ... }: {
  imports = [
    # inputs.niri.nixosModules.niri

    ./hypr
    ./variables.nix

  ];
  # programs.niri.enable = true;
}
