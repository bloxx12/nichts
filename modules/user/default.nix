{
  inputs,
  pkgs,
  ...
}: rec {
  packages = {
    fish = pkgs.callPackage ./shell {};
    helix = pkgs.callPackge ./helix {};
  };
  shell = pkgs.mkShell {
    name = "bloxx-shell";
    buildInputs = [packages.fish];
  };
  module = {
    config = {
      environment.systemPackages = [
        shell
      ];
    };
  };
}
