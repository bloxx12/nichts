{
  mkShellNoCC,
  git,
  writeShellApplication,
}:
mkShellNoCC {
  name = "nichts";

  DIRENV_LOG_FORMAT = "";

  packages = [
    git # take a guess

    (writeShellApplication {
      name = "update";
      text = ''
        nix flake update && git commit flake.lock -m "flake: bump inputs"
      '';
    })
  ];
}
