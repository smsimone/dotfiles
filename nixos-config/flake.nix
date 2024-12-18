{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    home-manager,
    nixpkgs,
    darwin,
    spicetify-nix,
  } @ inputs: let
    commonConfigs = {
      imports = [
        ./modules/common
      ];
    };

    darwinConfigs = {
      imports = [
        ./modules/darwin
        spicetify-nix.nixosModules.default
      ];
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = inputs;
      home-manager.users.simonemasoero = import ./home.nix;
      nixpkgs.config.allowUnfree = true;
      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;
    };
    raspConfigs = {
      import = [
        ./modules/rasp.nix
      ];
    };
  in {
    darwinConfigurations.airsmaso = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = {inherit inputs;};
      modules = [
        darwinConfigs
        commonConfigs
        home-manager.darwinModules.home-manager
      ];
    };

    nixosConfigurations.rasp = {
      system = "armv7l-linux";
      user = "smaso";
      modules = [
        commonConfigs
        raspConfigs
        home-manager.nixosModules.home-manager
      ];
    };
  };
}
