{
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    devShells.default = pkgs.mkShellNoCC {
      name = "nichts";

      DIRENV_LOG_FORMAT = "";

      inputsFrom = [config.treefmt.build.devShell];
      packages = [
        config.treefmt.build.wrapper # treewide formatter
        pkgs.git # take a guess

        (pkgs.writeShellApplication {
          name = "update";
          text = ''
            nix flake update && git commit flake.lock -m "flake: bump inputs"
          '';
        })
      ];
    };
  };
}
