# This shell setup was inspired by sioodmy. Check out his setup!
{pkgs, ...}: let
  toml = pkgs.formats.toml {};
  starship-config = import ./starship.nix;
in (pkgs.symlinkJoin {
  name = "fish-wrapped";
  paths = [pkgs.fish pkgs.starship pkgs.fzf];
  buildInputs = [pkgs.makeWrapper];
  postBuild = ''
    wrapProgram $out/bin/fish --set STARSHIP_CONFIG "${toml.generate "starship.toml" starship-config}" \
  '';
})
