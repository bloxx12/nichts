{
  perSystem = _: {
    pre-commit = {
      settings = {
        excludes = ["flake.lock"];
        hooks = {
          alejandra.enable = true;
          prettier.enable = true;
        };
      };
    };
  };
}
