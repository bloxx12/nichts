{lib, ...}: let
  inherit (builtins) filter map toString elem;
  inherit (lib.filesystem) listFilesRecursive;
  inherit (lib.strings) hasSuffix;

  # NOTE: This was bluntly taken from raf.

  # `mkModuleTree` is used to recursively import all Nix file in a given directory, assuming the
  # given directory to be the module root, where rest of the modules are to be imported. This
  # retains a sense of explicitness in the module tree, and allows for a more organized module
  # imports, discarding the vague `default.nix` name for directories that are *modules*.
  mkModuleTree = {
    path,
    ignoredPaths ? [./default.nix],
  }:
    filter (hasSuffix ".nix") (
      map toString (
        # List all files in the given path, and filter out paths that are in
        # the ignoredPaths list
        filter (path: !elem path ignoredPaths) (listFilesRecursive path)
      )
    );

  # A variant of mkModuleTree that provides more granular control over the files that are imported.
  # While `mkModuleTree` imports all Nix files in the given directory, `mkModuleTree'` will look
  # for a specific
  mkModuleTree' = {
    path,
    ignoredPaths ? [],
  }: (
    # Two conditions fill satisfy filter here:
    #  - The path should end with a module.nix, indicating
    #   that it is in fact a module file.
    #  - The path is not contained in the ignoredPaths list.
    # If we cannot satisfy both of the conditions, then the path will be ignored
    filter (hasSuffix "module.nix") (
      map toString (
        filter (path: !elem path ignoredPaths) (listFilesRecursive path)
      )
    )
  );
in {
  inherit mkModuleTree mkModuleTree';
}
