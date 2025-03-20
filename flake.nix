# To use this flake, I installed nix via the Determinate Systems installer.
#   https://zero-to-nix.com/start/install/
# For some reason, nix-darwin only accepts this file if it's living in
#   ~/.config/nix-darwin/flake.nix
# ...so symlink it with the following, ensuring you do not skip the full path in the first argument (lest you get a broken symlink):
#   ln -s ~/dotfiles/flake.nix ~/.config/nix-darwin/flake.nix
{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    nixDarwinConfig = { pkgs, ...}: {
      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;
      
      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;
      
      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#jackzezula
    darwinConfigurations."jackzezula" = nix-darwin.lib.darwinSystem {
      modules = [
        nixDarwinConfig
        ./configuration.nix # System settings I give a shit about
      ];
    };
  };
}
