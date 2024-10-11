{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs =
    {
      self,
      home-manager,
      nixpkgs,
      nix-darwin,
    }:
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#airsmaso

      darwinConfigurations = {
        airsmaso = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./configuration.nix
            ./application-configs
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.simonemasoero = import ./home.nix;
            }
          ];
        };
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."airsmaso".pkgs;
    };
}
