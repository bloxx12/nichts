# This shell setup was inspired by sioodmy. Check out his setup!
{pkgs, ...}: let
  toml = pkgs.formats.toml {};
  starship-config = import ./starship.nix;
  aliases = import ./aliases.nix {inherit pkgs;};

  fishinit = import ./fishinit.nix {inherit pkgs aliasesStr;};

  aliasesStr =
    pkgs.lib.concatStringsSep "\n"
    (pkgs.lib.mapAttrsToList (k: v: "alias ${k}=\"${v}\"") aliases);
  packages = import ./packages.nix pkgs;
in
  (pkgs.symlinkJoin {
    name = "fish-wrapped";
    paths = [pkgs.fish] ++ packages;
    buildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/fish --set STARSHIP_CONFIG "${toml.generate "starship.toml" starship-config}" \
    '';
  })
  .overrideAttrs (_: {
    passthru = {
      shellPath = "/bin/fish";
    };
  })
