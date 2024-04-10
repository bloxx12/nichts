{ pkgs, lib, config, ...}:
{
  imports = [
    ./cli/default.nix
    ./gui/default.nix
    ./other/default.nix
    ./services/default.nix
  ];
}
