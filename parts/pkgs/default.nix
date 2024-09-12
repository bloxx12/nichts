{inputs, ...}: {
  # NOTE: We use flake-parts' easyOverlay module to extend our default packages with some extra packages I want to have.
  #
  imports = [inputs.flake-parts.flakeModules.easyOverlay];
  perSystem = {
    config,
    lib,
    pkgs,
    ...
  }: {
    # Attributes to add to overlays.default.
    # The overlays.default overlay will re-evaluate perSystem with the “prev” (or “super”) overlay argument value
    # as the pkgs module argument. The easyOverlay module also adds the final module argument, for the result of applying the overlay.

    # When not in an overlay, final defaults to pkgs plus the generated overlay.
    # This requires Nixpkgs to be re-evaluated, which is more expensive than setting
    # pkgs to a Nixpkgs that already includes the necessary overlays that are required
    # for the flake itself.
    overlayAttrs = config.packages;

    packages = {
      nushell = import ./extraPackages/nushell-wrapped.nix {inherit inputs lib pkgs;};
    };
  };
}
