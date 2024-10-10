{
    description = "Nix configuration";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs";

        nix-darwin.url = "github:lnl7/nix-darwin/master";
        nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    };

     outputs = inputs@{ self, nix-darwin, nixpkgs }: {
        darwinConfigurations."airsmaso" = nix-darwin.lib.darwinSystem {
      modules = [ ./configuration.nix ];
    };
  };
}
