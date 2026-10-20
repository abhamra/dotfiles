# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "homeserver"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "ter-v32n";
    packages = [ pkgs.terminus_font ];
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.

  programs.fish.enable = true;

  users.users.arjun = {
    isNormalUser = true;
    description = "Arjun";
    extraGroups = [ "networkmanager" "wheel" ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [ (lib.removeSuffix "\n" (builtins.readFile ./secrets/server_key.pub)) ];
    packages = with pkgs; [
      tree
      gcc
      gnumake
      clang
      fastfetch
      fortune
      cowsay
      nodejs
      luarocks
      syncthing
    ];
    shell = pkgs.fish;
  };

  # programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    acpi
    btop
    tmux
    lm_sensors
    neovim
    fzf
    fish
    stow
    zoxide
    eza
    bat
    rustup
    ripgrep
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services.syncthing = {
    enable = true;
    user = "arjun";
    dataDir = "/home/arjun";
    configDir = "/home/arjun/.config/syncthing";
    guiAddress = "127.0.0.1:8384";   # not exposed; reach it via SSH tunnel
    openDefaultPorts = false;
  };

  # sync traffic only over the tailnet interface
  networking.firewall.interfaces."tailscale0" = {
    allowedTCPPorts = [ 22000 ];
    allowedUDPPorts = [ 22000 ];
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.PermitRootLogin = "no";
  };

  # to make sure shit doesn't sleep when I close the lid
  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleSwitchDocked = "ignore";
  };

  # Enable TLP power and battery management
  services.tlp = {
	  enable = true;
	  settings = {
		  # Stop charging when battery reaches 80% (or lower, like 60% for pure desktop/server use)
		  START_CHARGE_THRESH_BAT0 = 55;
		  STOP_CHARGE_THRESH_BAT0 = 60;
	  };
  };

  services.tailscale.enable = true;
  # services.tailscale.extraSetFlags = [ "--operator=arjun" ];
  networking.firewall = {
    enable = true;
    
    # Trust traffic coming over the Tailscale interface
    trustedInterfaces = [ config.services.tailscale.interfaceName ];
    
    # Allow Tailscale's direct UDP connection port
    allowedUDPPorts = [ config.services.tailscale.port ];
    
    # Optional: Keep reverse path check loose to prevent WireGuard connection drops
    checkReversePath = "loose";
  };

  # for tailscale auto receive!
  systemd.user.services.taildrop-auto-receive = {
    description = "Automatically receive Taildrop files";
    wantedBy = [ "default.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.tailscale}/bin/tailscale file get --loop --conflict=rename /home/your-username/Downloads";
      Restart = "always";
      RestartSec = "5s";
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}

