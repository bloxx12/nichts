{
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    devShells.default = pkgs.mkShellNoCC {
      name = "nichts";

      # shellHook = ''
      #   #  ${config.pre-commit.installationScript}
      # '';

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
        (pkgs.writeShellApplication {
          name = "rebuild";
          text = ''
            nh os switch
          '';
        })
      ];
    };
  };
}
