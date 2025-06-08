# ~/nixos-config/flake.nix
{
  description = "My NixOS Flake Configuration";

  inputs = {
    # NixOS official package source
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # Home Manager, locked to the same version as NixOS
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations."Swampert" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      # This is the modern, correct way to list all your configuration files.
      modules = [
        # Your main system configuration
        ./configuration.nix

        # Your user's home manager configuration
        ./users/wryan.nix

        # The Home Manager service itself
        home-manager.nixosModules.default
      ];
    };
  };
}
