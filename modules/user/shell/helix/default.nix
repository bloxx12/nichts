{
  inputs,
  pkgs,
  ...
}: let
  toml = pkgs.formats.toml {};
  inherit (inputs.helix.packages.${pkgs.stdenv.system}) helix;
  packages = with pkgs; [
    # C/C++
    clang-tools

    # Markdown
    marksman

    # Nix
    nil
    lldb_19
    # Bash
    bash-language-server

    # Shell
    shellcheck
  ];

  helix-config = import ./config.nix;

  helix-wrapped = pkgs.symlinkJoin {
    name = "fish-wrapped";
    paths = [helix] ++ packages;
    buildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/fish --set XDG_CONFIG_HOME "${toml.generate "config.toml" helix-config}"
    '';
  };
in
  helix-wrapped
