{ config, lib, pkgs, ... }:

let
  custom = config.services.forgejo.customDir;
  css = "${custom}/public/assets/css";
in
{
  services.forgejo = {
    enable = true;
    database.type = "postgres";
    lfs.enable = true;

    settings = {
      server = {
        DOMAIN = "git.abhamra.com";
        ROOT_URL = "https://git.abhamra.com/";
        HTTP_PORT = 3000;
        HTTP_ADDR = "127.0.0.1";
        LANDING_PAGE = "/abhamra";
      };
      service.DISABLE_REGISTRATION = true;
      ui = {
        THEMES = "abhamra-auto,abhamra-light,abhamra-dark,forgejo-auto,forgejo-light,forgejo-dark";
        DEFAULT_THEME = "abhamra-auto";
      };
    };
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "forgejo" ];
    ensureUsers = [
      {
        name = "forgejo";
        ensureDBOwnership = true;
      }
    ];
  };

  systemd.tmpfiles.rules = [
    "d '${custom}/public' - forgejo forgejo - -"
    "d '${custom}/public/assets' - forgejo forgejo - -"
    "d '${css}' - forgejo forgejo - -"
    "d '${custom}/public/assets/fonts' - forgejo forgejo - -"
    "C+ '${css}/abhamra-common.css' - forgejo forgejo - ${./forgejo-theme/abhamra-common.css}"
    "C+ '${css}/theme-abhamra-light.css' - forgejo forgejo - ${./forgejo-theme/theme-abhamra-light.css}"
    "C+ '${css}/theme-abhamra-dark.css' - forgejo forgejo - ${./forgejo-theme/theme-abhamra-dark.css}"
    "C+ '${css}/theme-abhamra-auto.css' - forgejo forgejo - ${./forgejo-theme/theme-abhamra-auto.css}"
  ];

  # Cloudflare Tunnel: outbound connection to Cloudflare, so no open ports
  # or router access are needed. Ingress (git.abhamra.com -> 127.0.0.1:3000)
  # is configured in the Cloudflare dashboard.
  systemd.services.cloudflared-tunnel = {
    description = "Cloudflare Tunnel";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      EnvironmentFile = "/var/lib/nixos-secrets/cloudflared.env";
      ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run";
      Restart = "always";
      RestartSec = "5s";
      DynamicUser = true;
    };
  };
}
