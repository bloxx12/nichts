{, ...}: rec {
  module = {
    config = {
      environment.sessionVariables.EDITOR = "hx";
      environment.systemPackages = builtins.attrValues {
        inherit (packages) fish helix;
      };
    };
  };
}
