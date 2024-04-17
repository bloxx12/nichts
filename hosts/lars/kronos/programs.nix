{ config, inputs, pkgs, lib, ... }:
let
  username = config.modules.other.system.username;

  # Fetch the GLFW with Wayland patches for Minecraft
  customGLFW = let
    mcWaylandPatchRepo = pkgs.fetchFromGitHub {
      owner = "Admicos";
      repo = "minecraft-wayland";
      rev = "370ce5b95e3ae9bc4618fb45113bc641fbb13867";
      sha256 = "sha256-RPRg6Gd7N8yyb305V607NTC1kUzvyKiWsh6QlfHW+JE=";
    };
    mcWaylandPatches = map (name: "${mcWaylandPatchRepo}/${name}")
      (lib.naturalSort (builtins.attrNames (lib.filterAttrs
        (name: type:
          type == "regular" && lib.hasSuffix ".patch" name)
        (builtins.readDir mcWaylandPatchRepo))));
  in pkgs.glfw.overrideAttrs (previousAttrs: {
    patches = previousAttrs.patches ++ mcWaylandPatches;
    buildInputs = previousAttrs.buildInputs ++ [ pkgs.wayland ];
  });

  # Minecraft launcher with the custom GLFW
  minecraftPrismLauncher = pkgs.prismlauncher.override {
    glfw = customGLFW;
  };

in {
    home-manager.users.${username} = {
        home.packages = let
          fenix = inputs.fenix.packages.${pkgs.system};

        in with pkgs; [
        ];
    };

    # System-wide installation of Minecraft PrismLauncher
    environment.systemPackages = [
        minecraftPrismLauncher
    ];
}
