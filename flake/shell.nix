{
  perSystem = {pkgs, ...}: {
    devShells.default = pkgs.mkShellNoCC {
      name = "nichts";
      DIRENV_LOG_FORMAT = "";
      packages = with pkgs; [
        nil # nix language server
        alejandra
        git # take a guess
        statix # no idea
        deadnix # clean up unused nix code

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
