# This shell setup was inspired by sioodmy. Check out his setup!
{
  lib,
  pkgs,
  ...
}: let
  toml = pkgs.formats.toml {};
  starship-config = import ./starship.nix;
  aliases = import ./aliases.nix {inherit pkgs;};

  fishinit = import ./fishinit.nix {inherit pkgs aliasesStr;};

  aliasesStr =
    pkgs.lib.concatStringsSep "\n"
    (pkgs.lib.mapAttrsToList (k: v: "alias ${k}=\"${v}\"") aliases);
  packages = import ./packages.nix pkgs;

  # this was taken from viperml, check out his config for this!
  custom-fish = pkgs.fish.overrideAttrs (old: {
    patches = [./fish-on-tmpfs.patch];
    doCheck = false;
    postInstall =
      old.postInstall
      + ''
        echo "source ${fishinit}" >> $out/etc/fish/config.fish
      '';
  });
in
  (pkgs.symlinkJoin {
    name = "fish-wrapped";
    paths = [custom-fish] ++ packages;
    buildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/fish --set STARSHIP_CONFIG "${toml.generate "starship.toml" starship-config}" \
      --set SSH_AUTH_SOCK /run/user/1000/ssh-agent \
    '';
  })
  .overrideAttrs (_: {
    passthru = {
      shellPath = "/bin/fish";
    };
  })
