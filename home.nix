{ config, pkgs, ... }:

{

  fonts.fontconfig.enable = true;

  home = {
    username = "jack.z";
    homeDirectory = "/Users/jack.z";
    # Specify packages not explicitly configured below
    packages = with pkgs; [
      docker
      fd
      neovim
      ripgrep
      starship
      tree
      tree-sitter
      youtube-dl
      (pkgs.nerdfonts.override {fonts = ["FiraCode" "DroidSansMono"]; })
    ];
    stateVersion = "21.11";
  };

  programs = {
    alacritty = {
      enable = true;
      settings = {
        cursor.style = "Beam";
        font = {
          family = "DroidSansMono";
          size = 18;
        };
        prompt = "echo (starship prompt)";
        # Change the default shell to home-manager's fish rather than the system default
        shell.program = "${config.home.profileDirectory}/bin/fish";
        window.dimensions = {
          lines = 50;
          columns = 100;
          opacity = 0.95;
        };
      };
    };

    bat = {
      enable = true;
      config = {
        theme = "GitHub";
        italic-text = "always";
      };
    };

    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };

    fish = {
      enable = true;
      plugins = [
        {
          name = "iterm2-shell-integration";
          src = ./config/fish/iterm2_shell_integration;
        }
        {
          name = "fzf";
          src = pkgs.fetchFromGitHub {
            owner = "PatrickF1";
            repo = "fzf.fish";
            rev = "6d8e962f3ed84e42583cec1ec4861d4f0e6c4eb3";
            sha256 = "sha256-0rnd8oJzLw8x/U7OLqoOMQpK81gRc7DTxZRSHxN9YlM";
          };
        }
        # Need this when using Fish as a default macOS shell in order to pick
        # up ~/.nix-profile/bin
        {
          name = "nix-env";
          src = pkgs.fetchFromGitHub {
            owner = "lilyball";
            repo = "nix-env.fish";
            rev = "00c6cc762427efe08ac0bd0d1b1d12048d3ca727";
            sha256 = "1hrl22dd0aaszdanhvddvqz3aq40jp9zi2zn0v1hjnf7fx4bgpma";
          };
        }
      ];
      interactiveShellInit = ''
        # Activate the iTerm 2 shell integration
        iterm2_shell_integration
        # Manually load starship
        starship init fish | source
      '';
      shellAliases = {
        nvim = "nvim -p";
        vim = "vim -p";
        rm = "rm -i";
        cp = "cp -i";
        mv = "mv -i";
        mkdir = "mkdir -p";
        du = "du -hs";
      };
      # Abbreviate commonly used functions
      # An abbreviation will expand after <space> or <Enter> is hit
      shellAbbrs = {
        b = "bat";
        g = "git";
        hme = "home-manager -f ~/dotfiles/home.nix edit";
        hms = "home-manager -f ~/dotfiles/home.nix switch";
        n = "nvim";
        o = "open";
      };
      functions = {
        ctrlp = {
          description = "Launch Neovim file finder from the shell";
          argumentNames = "hidden";
          body = ''
            if test -n "$hidden"
              # TODO can't find a way to toggle hidden files in Helix yet
              nvim -c 'lua require(\'telescope.builtin\').find_files({hidden = true})'
            else
              hx .
            end
          '';
        };
        fish_greeting = {
          description = "Greeting to show when starting a fish shell";
          body = "";
        };
        fish_mode_prompt = {
          description = "Vim mode in fish";
          body = "fish_default_mode_prompt";
        };
        fish_user_key_bindings = {
          description = "Set custom key bindings";
          body = ''
            # Add shortcuts for functions defined in the above config
            bind \cp ctrlp
            bind \cl 'ctrlp --hidden'

            # Use vim bindings (--no-erase preserves the above shortcuts)
            fish_vi_key_bindings insert
          '';
        };
        mkdcd = {
          description = "Make a directory tree and enter it";
          body = "mkdir -p $argv[1]; and cd $argv[1]";
        };
        nvimrg = {
          description = "Open files matched by ripgrep with Neovim";
          body = "nvim (rg -l $argv) +/\"$argv[-1]\"";
        };
      };
    };

    fzf = {
      enable = true;
      enableFishIntegration = false;
    };

    gh = {
      enable = true;
      settings = {
        aliases = {
          pv = "pr view";
        };
        git_protocol = "ssh";
      };
    };

    git = {
      enable = true;
      userName = "Jack Zezula ";
      userEmail = "jack.z@canva.com";
      aliases = {
        a = "add";
        b = "branch";
        cm = "commit";
        cma = "commit --amend";
        cman = "commit --amend --no-edit";
        cmm = "commit -m";
        co = "checkout";
        cob = "checkout -b";
        d = "diff";
        ds = "diff --staged";
        del = "branch -d";
        lg = "!git log --pretty=format:\"%C(magenta)%h%Creset -%C(red)%d%Creset %s %C(dim green)(%cr) [%an]\" --abbrev-commit -30";
        lgo = "log --oneline";
        r = "rebase";
        ri = "rebase -i";
        s = "status";
        st = "stash";
        prettylog = "log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
      };
      delta = {
        enable = true;
        options = {
          navigate = true;
          line-numbers = true;
          syntax-theme = "GitHub";
        };
      };
      extraConfig = {
        core = {
          # If git uses `ssh` from Nix the macOS-specific configuration in
          # `~/.ssh/config` won't be seen as valid
          # https://github.com/NixOS/nixpkgs/issues/15686#issuecomment-865928923
          sshCommand = "/usr/bin/ssh";
        };
        color = {
          ui = true;
        };
        diff = {
          colorMoved = "default";
        };
        merge = {
          conflictstyle = "zdiff3";
        };
        push = {
          default = "current";
        };
        pull = {
          ff = "only";
        };
        init = {
          defaultBranch = "main";
        };
        # Clone git repos with URLs like "gh:alexpearce/dotfiles"
        url."git@github.com:" = {
          insteadOf = "gh:";
          pushInsteadOf = "gh:";
        };
      };
      ignores = [
        ".*.swp"
        ".bundle"
        "vendor/bundle"
        ".DS_Store"
        "Icon"
        "*.pyc"
        ".envrc"
        "environment.yaml"
      ];
    };

    helix = {
      enable = true;
      settings = {
        theme = "onelight";
        editor = {
          bufferline = "multiple";
          color-modes = true;
          lsp.display-messages = true;
        };
        keys.normal = {
          space.w = ":w";
          space.q = ":q";
          space.x = ":x";
        };
      };
    };

    home-manager = {
      # This needs to be true for this entire config to take effect
      enable = true;
    };

    # starship = {
    #   enable = true;
    #   enableFishIntegration = true;
    #   settings = {
    #     add_newline = false;
    #   };
    # };

    tmux = {
      enable = true;
      baseIndex = 1;
      historyLimit = 100500;
      keyMode = "emacs";
      prefix = "C-Space";
      extraConfig = ''
        # Reduce timeout to prevent impact on vim within tmux
        set -sg escape-time 10
        set -s escape-time 0

        # Enable mouse mode
        set-option -g mouse on
      '';
      plugins = [ pkgs.tmuxPlugins.yank ];
      # Change the default shell to home-manager's fish rather than the system default
      shell = "${config.home.homeDirectory}/.nix-profile/bin/fish";
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };

  # FIXME The init.vim unconditionally installed by this module conflicts with
  # our init.lua, so we cannot use the module for now and must install the
  # configuration explicitly
  xdg.configFile.nvim = {
    source = ./config/neovim;
    recursive = true;
  };

  xdg.configFile."starship.toml" = {
    source = ./config/starship.toml;
  };
}
