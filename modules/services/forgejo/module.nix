{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (config.services.forgejo) customDir user group;
  cfg = config.modules.system.services.forgejo;

  port = 3000;
  domain = "copeberg.org";
  img = ./img;
  acmeRoot = "/var/lib/acme/challenges-forgejo";
  dataDir = "/srv/data/forgejo";
in {
  options.modules.system.services.forgejo.enable = lib.mkEnableOption "forgejo";

  config = mkIf cfg.enable {
    modules.system.services = {
      database.postgresql.enable = true;
    };

    networking.firewall.allowedTCPPorts = [
      443
      80
    ];

    services.nginx = {
      enable = true;
      virtualHosts.${domain} = {
        forceSSL = true;
        # enableACME = true;
        useACMEHost = domain;
        inherit acmeRoot;
        extraConfig = ''
          # nginx defaults to a 1MB size limit for uploads, which
          # *definitely* isn't enough for Git LFS.
          # 'client_max_body_size 300m;' would set a limit of 300MB
          # setting it to 0 means "no limit"
          client_max_body_size 512M;
        '';
        locations."/" = {
          recommendedProxySettings = true;
          proxyPass = "http://localhost:${toString port}";
        };
      };
    };

    security.acme = let
      email = "charlie@charlieroot.dev";
    in {
      acceptTerms = true;
      defaults.email = email;
      defaults.server = "https://acme-staging-v02.api.letsencrypt.org/directory";
      certs = {
        ${domain} = {
          webroot = acmeRoot;
          inherit email;
          group = "nginx";
        };
      };
    };

    # create the git user for forgejo
    # NOTE: this is important and it will _not_ work otherwise.
    users.users.git = {
      home = dataDir;
      useDefaultShell = true;
      group = "git";
      isSystemUser = true;
    };
    users.groups.git = {};

    services.forgejo = {
      enable = true;
      package = pkgs.forgejo;
      stateDir = dataDir;

      user = "git";
      group = "git";
      database = {
        createDatabase = true;
        name = "git";
        user = "git";
        type = "postgres";
      };

      # Disable support for Git Large File Storage
      lfs.enable = false;

      settings = {
        server = {
          DOMAIN = domain;
          # You need to specify this to remove the port from URLs in the web UI.
          ROOT_URL = "https://${domain}/";
          HTTP_PORT = port;
        };
        DEFAULT = {
          APP_NAME = "Copeberg.org";
          APP_SLOGAN = "Code and seethe.";
        };
        # disable registration by default.
        service.DISABLE_REGISTRATION = true;

        # Add support for actions, based on act: https://github.com/nektos/act
        actions = {
          ENABLED = false;
          DEFAULT_ACTIONS_URL = "github";
        };

        "repository.signing" = {
          SIGNING_KEY = "none";
        };
      };
    };

    systemd.tmpfiles.rules = let
      # no crawlers, thank you.
      robots = pkgs.writeText "robots-txt" ''
        User-agent: *
        Disallow: /
      '';
    in [
      "d '${customDir}/public' 0750 ${user} ${group} - -"
      "d '${customDir}/public/assets' 0750 ${user} ${group} - -"
      "d '${customDir}/public/assets/img' 0750 ${user} ${group} - -"

      "L+ '${customDir}/public/assets/img/logo.svg' - - - - ${img}/logo.svg"
      "L+ '${customDir}/public/assets/img/logo.png' - - - - ${img}/logo.png"
      "L+ '${customDir}/public/assets/img/apple-touch-icon' - - - - ${img}/logo.png"
      "L+ '${customDir}/public/assets/img/favicon.svg' - - - - ${img}/logo.svg"
      "L+ '${customDir}/public/assets/img/favicon.png' - - - - ${img}/logo.png"

      "L+ ${customDir}/public/robots.txt - - - - ${robots.outPath}"
    ];
  };
}
