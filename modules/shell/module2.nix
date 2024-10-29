# This shell setup was inspired by sioodmy. Check out his setup!
{pkgs, ...}: let
  toml = pkgs.formats.toml {};
  starship-config = import ./starship.nix;
  aliases = import ./aliases.nix;

  fishinit = import ./fishinit.nix {inherit pkgs aliasesStr;};

  aliasesStr =
    pkgs.lib.concatStringsSep "\n"
    (pkgs.lib.mapAttrsToList (k: v: "alias ${k}=\"${v}\"") aliases);

in (pkgs.symlinkJoin {
  name = "fish-wrapped";
  paths = [pkgs.fish pkgs.starship pkgs.fzf];
  buildInputs = [pkgs.makeWrapper];
  postBuild = ''
    wrapProgram $out/bin/fish --set STARSHIP_CONFIG "${toml.generate "starship.toml" starship-config}" \
  '';
})
