{
  config,
  pkgs,
}: {
  services.miniflux = {
    enable = true;
    createDatabaseLocally = true;
  };
}
