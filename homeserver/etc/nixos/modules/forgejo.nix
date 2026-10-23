{ config, lib, pkgs, ... }:

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
      };
      service.DISABLE_REGISTRATION = true;
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
