{ config, lib, pkgs, ... }:

{
  programs.fish.enable = true;

  users.users.arjun = {
    isNormalUser = true;
    description = "Arjun";
    extraGroups = [ "networkmanager" "wheel" ];
    # openssh.authorizedKeys.keys = [ (lib.removeSuffix "\n" (builtins.readFile ../secrets/server_key.pub)) ];
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

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    acpi
    btop
    tmux
    lm_sensors
    unzip
    neovim
    fzf
    fish
    stow
    zoxide
    eza
    bat
    rustup
    ripgrep
    borgbackup
  ];
}
