{ self, pkgs, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [ 
    duti
    vim
    # vlc # someday we'll have aarch64 support, but not today
  ];
  
  homebrew = {
    enable = true;
    casks = [ "vlc" ];
  };

  # Permits nix-darwin to work with Determinate
  nix.enable = false;
  
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
  
  # Enable alternative shell support in nix-darwin.
  programs.fish.enable = true;

  # Use touch ID instead of password for sudo
  security.pam.enableSudoTouchIdAuth = true;

  system.defaults.dock.autohide = true;

  # Permits unfree packages like Raycast
  nixpkgs = {
    config = {
      allowBroken = true;
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  system.activationScripts.setVLC = {
    text = ''
      ${pkgs.duti}/bin/duti -s org.videolan.vlc public.mpeg-4 all   # .mp4
      ${pkgs.duti}/bin/duti -s org.videolan.vlc public.avi all      # .avi
      ${pkgs.duti}/bin/duti -s org.videolan.vlc public.mpeg all     # .mpg, .mpeg
      ${pkgs.duti}/bin/duti -s org.videolan.vlc public.mp3 all      # .mp3
      ${pkgs.duti}/bin/duti -s org.videolan.vlc public.aiff all     # .aiff
      ${pkgs.duti}/bin/duti -s org.videolan.vlc public.wav all      # .wav
      ${pkgs.duti}/bin/duti -s org.videolan.vlc com.apple.m4a-audio all  # .m4a
      ${pkgs.duti}/bin/duti -s org.videolan.vlc public.ogg-audio all # .ogg
      ${pkgs.duti}/bin/duti -s org.videolan.vlc public.flac all     # .flac
      ${pkgs.duti}/bin/duti -s org.videolan.vlc public.3gpp all     # .3gp
      ${pkgs.duti}/bin/duti -s org.videolan.vlc public.3gpp2 all    # .3g2
      ${pkgs.duti}/bin/duti -s org.videolan.vlc public.mkv all      # .mkv
      ${pkgs.duti}/bin/duti -s org.videolan.vlc public.mov all      # .mov
      ${pkgs.duti}/bin/duti -s org.videolan.vlc public.aac-audio all # .aac
      ${pkgs.duti}/bin/duti -s org.videolan.vlc public.ac3-audio all # .ac3
      ${pkgs.duti}/bin/duti -s org.videolan.vlc public.m3u-playlist all # .m3u
    '';
  };
}
