{
  inputs,
  pkgs,
  ...
}: rec {
  packages = {
    fish = pkgs.callPackage ./shell {};
    helix = pkgs.callPackage ./helix {inherit (inputs.helix.packages.${pkgs.stdenv.system}) helix;};
    kakoune = pkgs.callPackage ./kakoune {};
  };
  shell = pkgs.mkShell {
    name = "bloxx-shell";
    buildInputs = [packages.fish];
  };
  module = {
    config = {
      environment.systemPackages = with packages; [
        fish
        helix
      ];
    };
  };
}
