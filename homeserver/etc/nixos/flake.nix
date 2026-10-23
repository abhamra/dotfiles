{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    github2forgejo = {
      url = "github:RGBCube/GitHub2Forgejo";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, github2forgejo, ... } @ inputs: {
    nixosConfigurations.homeserver = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # External module
        github2forgejo.nixosModules.default
        {
          nixpkgs.overlays = [ github2forgejo.overlays.default ];

          services.github2forgejo = {
            enable = true;
            environmentFile = "/var/lib/nixos-secrets/github2forgejo.env";
          };
        }

        # Your system configuration files
        ./hardware-configuration.nix
        ./configuration.nix
      ];
    };
  };
}
