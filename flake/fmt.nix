{
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    # https://github.com/numtide/treefmt-nix?tab=readme-ov-file#flake-parts
    formatter = config.treefmt.build.wrapper;
    treefmt = {
      projectRootFile = "flake.nix";
      programs = {
        alejandra.enable = true;

        shellcheck.enable = true; # cannot be configured, errors on basic bash convention

        prettier = {
          enable = true;
          package = pkgs.prettierd;
          excludes = ["*.age"];
          settings = {
            editorconfig = true;
          };
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
