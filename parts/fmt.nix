{inputs, ...}: {
  imports = [inputs.treefmt-nix.flakeModule];
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    # https://github.com/numtide/treefmt-nix?tab=readme-ov-file#flake-parts
    formatter = config.treefmt.build.wrapper;

    treefmt = {
      projectRootFile = "flake.nix";
      enableDefaultExcludes = true;
      settings = {
        global.excludes = ["*.png"];
      };
      programs = {
        alejandra.enable = true;

        shellcheck.enable = true;

        prettier = {
          enable = true;
          package = pkgs.prettierd;
          settings.editorconfig = true;
        };

        shfmt = {
          enable = true;
          # https://flake.parts/options/treefmt-nix.html#opt-perSystem.treefmt.programs.shfmt.indent_size
          indent_size = 2; # set to 0 to use tabs
        };
      };
    };
  };
}
