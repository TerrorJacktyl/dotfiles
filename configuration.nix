{ self, pkgs, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
  [ pkgs.vim
  ];
  
  # Permits nix-darwin to work with Determinate
  nix.enable = false;
  
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
  
  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;

  # Use touch ID instead of password for sudo
  security.pam.enableSudoTouchIdAuth = true;

  system.defaults.dock.autohide = true;

  # Permits unfree packages like Raycast
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };
}
