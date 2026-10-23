{ config, lib, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.PermitRootLogin = "no";
  };

  services.syncthing = {
    enable = true;
    user = "arjun";
    dataDir = "/home/arjun";
    configDir = "/home/arjun/.config/syncthing";
    guiAddress = "127.0.0.1:8384";
    openDefaultPorts = false;
  };

  services.tailscale.enable = true;

  networking.firewall = {
    enable = true;
    trustedInterfaces = [ config.services.tailscale.interfaceName "tailscale0" ];
    allowedUDPPorts = [ config.services.tailscale.port 22000 ];
    allowedTCPPorts = [ 22000 ];
    checkReversePath = "loose";
  };

  systemd.user.services.taildrop-auto-receive = {
    description = "Automatically receive Taildrop files";
    wantedBy = [ "default.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.tailscale}/bin/tailscale file get --loop --conflict=rename /home/arjun/drive";
      Restart = "always";
      RestartSec = "5s";
    };
  };

  systemd.services.borg-backup = {
    description = "Daily Borg Backup to Hetzner Storage Box";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    script = ''
      export BORG_PASSPHRASE='${lib.removeSuffix "\n" (builtins.readFile ../secrets/.borg-passphrase)}'
      exec ${pkgs.borgbackup}/bin/borg create -v --stats \
          ssh://u696621@u696621.your-storagebox.de:23/./backups/homeserver::{now:%Y-%m-%d_%H:%M} \
          /home/arjun \
          --exclude '/home/arjun/dotfiles' \
          --exclude '/home/arjun/.cache'
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "arjun";
    };
  };

  systemd.timers.borg-backup = {
    description = "Daily Borg Backup Timer";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
    };
  };
}
