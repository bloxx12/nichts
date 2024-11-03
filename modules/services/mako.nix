{pkgs, ...}: let
  mako-wrapped = pkgs.symlinkJoin {
    name = "mako-wrapped";
    paths = [pkgs.mako];
    buildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/mako --add-flags "\
      --font 'Lexend 11' \
      --border-radius 8 \
      --padding 8 \
      --border-size 5 \
      --default-timeout 4000"
    '';
  };
in {
  environment.systemPackages = [mako-wrapped];
}
