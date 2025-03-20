# To use this flake, I installed nix via the Determinate Systems installer.
#   https://zero-to-nix.com/start/install/
{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, mac-app-util }:
  let
    nixDarwinConfig = { pkgs, ... }: {
      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;
      
      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;
      
      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      # Home directory
      users.users.jackzezula.home = "/Users/jackzezula";
    };
  in {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#jackzezula
    darwinConfigurations."jackzezula" = nix-darwin.lib.darwinSystem {
      modules = [
        nixDarwinConfig
        ./configuration.nix # System settings I give a shit about
        home-manager.darwinModules.home-manager
        {
          # Make nix-installed applications available to spotlight/cmd-space searches
          home-manager.sharedModules = [ mac-app-util.homeManagerModules.default ];
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.jackzezula = import ./home.nix;
        }
      ];
    };
  };
}
