{pkgs, ...}: rec {
  packages = {
    fish = pkgs.callPackage ./shell {};
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
