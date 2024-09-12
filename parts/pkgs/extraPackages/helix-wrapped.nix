{
  inputs',
  inputs,
  lib,
  pkgs,
  ...
}: let
  helix-wrapped = inputs.wrapper-manager.lib.build {
    inherit pkgs;
    modules = [
      {
        wrappers.nushell-wrapped = {
          basePackage = inputs'.helix.packages.default;
          pathAdd = with pkgs; [
            # C/C++
            clang-tools

            # Markdown
            marksman

            # Nix
            nil

            # Bash
            bash-language-server

            # Shell
            shellcheck
          ];
        };
      }
    ];
  };
in
  helix-wrapped
