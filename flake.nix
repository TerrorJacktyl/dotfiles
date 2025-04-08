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
    username = "jackzezula"; # Change this if you're not Jack, or you're Jack going undercover
    userInfoFor = system:
      let
        pkgs = import nixpkgs { inherit system; };

        homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";
        flakeDirectory = "${homeDirectory}/dotfiles"; # if you haven't cloned the repo here, you're in big trouble
      in { inherit username flakeDirectory homeDirectory pkgs; };

    DARWIN_PLATFORM = "aarch64-darwin";
    darwin = userInfoFor DARWIN_PLATFORM;
    # Some day, a beautiful Linux home-manager or NixOS configuration will go here...

    nixDarwinConfig = { pkgs, ... }: {
      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;
      
      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;
      
      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = DARWIN_PLATFORM;

      # Home directory
      users.users.${username}.home = darwin.homeDirectory;
    };
  in {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#jackzezula
    darwinConfigurations.${username} = nix-darwin.lib.darwinSystem {
      modules = [
        nixDarwinConfig
        ./configuration.nix # System settings I give a shit about
        home-manager.darwinModules.home-manager
        {
          # Make nix-installed applications available to spotlight/cmd-space searches
          home-manager.sharedModules = [ mac-app-util.homeManagerModules.default ];
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ./home.nix { inherit (darwin) username flakeDirectory homeDirectory; };
        }
      ];
    };
  };
}
