{ pkgs, lib, config, ...}:
{
  imports = [
    ./core/boot/boot.nix
    ./graphics/default.nix
    #./web/default.nix
    #./terminal/default.nix
  ];
}
