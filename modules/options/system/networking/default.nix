{lib, ...}: let
  inherit (lib) mkEnableOption mkOption types;
in {
  options.modules.system.networking = {
    nftbles.enable = mkEnableOption "Nftables firewall";
  };
}
