{ config, lib, pkgs, ... }:

{
  services.forgejo = {
    enable = true;
    database.type = "postgres";
    
    # Enable Git LFS (Large File Storage) if needed
    lfs.enable = true;

    settings = {
      server = {
        DOMAIN = "git.abhamra.com";
        ROOT_URL = "https://git.abhamra.com/";
        HTTP_PORT = 3000; # Internal port for Forgejo
        HTTP_ADDR = "127.0.0.1";
      };
      # If it's just for you, lock down public sign-ups after creating your admin account
      service.DISABLE_REGISTRATION = true;
    };
  };

  # Setup PostgreSQL for Forgejo's database
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

  # Reverse proxy with Nginx + automated Let's Encrypt SSL
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."git.abhamra.com" = {
      forceSSL = true;
      enableACME = true; # Uses certifiate manager to handle SSL for abhamra.com
      locations."/" = {
        proxyPass = "http://127.0.0.1:3000";
        proxyWebsockets = true; # Needed for certain real-time features/actions
      };
    };
  };

  # Make sure ACME has a valid email for Let's Encrypt notifications
  security.acme = {
    acceptTerms = true;
    defaults.email = "arjun.bhamra25@gmail.com";
  };
}
