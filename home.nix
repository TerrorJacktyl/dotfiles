{ config, pkgs, ... }:

{

  fonts.fontconfig.enable = true;

  home = {
    username = "jackzezula";
    homeDirectory = "/Users/jackzezula";
    stateVersion = "21.11";

    # Specify packages not explicitly configured below
    packages = with pkgs; [
      # neovim
      neovim
      luajitPackages.luarocks # required by lazy package manager
      # ocaml
      ocaml
      opam
      dune_3

      coreutils # for git feature branch function
      docker
      fd
      ripgrep
      tree
      youtube-dl
      (pkgs.nerdfonts.override {fonts = ["FiraCode" "DroidSansMono"]; })
      # unfree packages
      raycast
    ];
  };

  # Configuration for nix provided by home-manager, special
  nix.package = pkgs.nix;
  nix.settings = {
    experimental-features = "nix-command";
  };

  # Permits unfree packages like Raycast
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  programs = {
    home-manager = {
      # This needs to be true for this entire config to take effect
      enable = true;
    };

    alacritty = {
      settings = {
        font.size = 16;
      };
    };

    bat = {
      enable = true;
      config = {
        theme = "TwoDark";
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
      interactiveShellInit = ''
        # Activate the iTerm 2 shell integration
        # iterm2_shell_integration

        # Make fzf use fd because it's faster than find
        set --universal FZF_DEFAULT_COMMAND 'fd'

        # allow finding programs installed by go
        fish_add_path $HOME/go/bin
        # allow homebrew and its programs
        fish_add_path /opt/homebrew/bin
      '';
      plugins = [
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
        cf = "code (fd . . | fzf)";
        cr = "vscode_from_fuzzy_ripgrep";
        fr = "filename_from_fuzzy_ripgrep";
        hme = "EDITOR=(which nvim) home-manager -f ~/dotfiles/home.nix edit";
        hms = "home-manager -f ~/dotfiles/home.nix switch";
        n = "nvim";
        o = "open";
      };
      functions = {
        string_to_args = {
          description = "Convert a string containing spaces to a list, which when substituted will act like each word was typed as a separate command";
          argumentNames = "s";
          body = "string split ' ' -- $s";
        };
        vscode_from_fuzzy_ripgrep = {
          description = "Filter file contents using ripgrep, select a match from a fuzzy-search, and finally open the selection in VSCode.";
          body = "code --goto (filename_and_line_from_fuzzy_ripgrep $argv)";
        };
        filename_and_line_from_fuzzy_ripgrep = {
          description = "Filter file contents using ripgrep, select a match from a fuzzy-search, and finally return the path and line number of the match. For example, path/to/file:23";
          body = "rg --line-number (string_to_args \"$argv\") | fzf | string match --regex -g -- '^([^:]+:\\d+):'";
        };
        filename_from_fuzzy_ripgrep = {
          description = "Filter file contents using ripgrep, select a match from a fuzzy-search, and finally return the path in the match.";
          body = "rg (string_to_args \"$argv\") | fzf | string match --regex -g -- '^([^:]*):'";
        };
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
        fish_prompt = {
          description = "Main prompt (ie directory and username).";
          body = ''
            set -l prompt_elements ()

            set -l pwd_display (string join "" -- (set_color $fish_color_cwd) (prompt_pwd) (set_color normal))
            set -a prompt_elements $pwd_display

            # Prompt status only if it's not 0
            set -l last_status $status
            set -l stat_display
            if test $last_status -ne 0
                set stat_display (string join "" -- (set_color red)"[$last_status]"(set_color normal))
                set -a prompt_elements $stat_display
            end

            # Git branch
            set -l branch (git branch --show-current &> /dev/null)
            set -l head (git rp --short HEAD &> /dev/null)
            set -l maybe_git_ref
            if test -n "$branch"
              set maybe_git_ref "$branch"
            else if test -n "$head"
              set maybe_git_ref "$head"
            end
            if test -n "$maybe_git_ref"
              set branch_display (string join "" -- (set_color $fish_color_user) "($maybe_git_ref)" (set_color normal))
              set -a prompt_elements $branch_display
            end

            # Final character
            set -a prompt_elements "λ "

            string join " " -- $prompt_elements
          '';
        };
        fish_right_prompt = {
          description = "Right prompt in fish";
          body = "";
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
      userEmail = "jackzezula@tuta.io";
      aliases = {
        a = "add";
        b = "branch";
        cm = "commit";
        cma = "commit --amend";
        cman = "commit --amend --no-edit";
        cmm = "commit -m";
        co = "checkout";
        cob = "checkout -b";
        cof = "!f() { git checkout -b \"zez/$(date -I)-$1\"; }; f";
        d = "diff";
        ds = "diff --staged";
        del = "branch -d";
        fo = "!git fetch origin \"$1\":\"$1\" #";
        fog = "fo green";
        fom = "fo master";
        lg = "!git log --pretty=format:\"%C(magenta)%h%Creset -%C(red)%d%Creset %s %C(dim green)(%cr) [%an]\" --abbrev-commit -30";
        lgo = "log --oneline";
        po = "!git pull origin \"$1\" #";
        r = "rebase";
        ri = "rebase -i";
        # Useful for checking out a branch (e.g. master) without blocking other worktrees from using the same branch.
        rp = "rev-parse";
        rpm = "rev-parse master";
        rpg = "rev-parse green";
        s = "status";
        st = "stash";
        prettylog = "log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
      };
      delta = {
        enable = true;
        options = {
          navigate = true;
          line-numbers = true;
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
        commit = {
          gpgsign = false;
        };
        init = {
          defaultBranch = "main";
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

    tmux = {
      enable = true;
      baseIndex = 1;
      historyLimit = 100500;
      keyMode = "emacs";
      plugins = with pkgs; [
        # tmuxPlugins.cpu
        {
          plugin = tmuxPlugins.resurrect;
          # extraConfig = "set -g @resurrect-strategy-nvim 'session'";
        }
        {
          plugin = tmuxPlugins.continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
            set -g @continuum-save-interval '5' # minutes
          '';
        }
        pkgs.tmuxPlugins.yank
      ];
      prefix = "C-a";
      extraConfig = ''
        # Set default shell to fish
        set -g default-shell "${config.home.homeDirectory}/.nix-profile/bin/fish";
        set -g default-command "${config.home.homeDirectory}/.nix-profile/bin/fish";

        # Reduce timeout to prevent impact on vim within tmux
        set -sg escape-time 10
        set -s escape-time 0

        # Enable mouse mode
        set-option -g mouse on

        # Make the colours compatible with neovim
        set-option -g default-terminal screen-256color

        # Shortcuts
          # reload config file (change file location to your the tmux.conf you want to use)
          bind r source-file ~/.config/tmux/tmux.conf

          # split panes using v and s (like vim), keeping current directory
          bind v split-window -h -c "#{pane_current_path}"
          bind s split-window -v -c "#{pane_current_path}"
          unbind '"'
          unbind %

          # resize panes more easily
          bind < resize-pane -L 10
          bind > resize-pane -R 10
          bind - resize-pane -D 10
          bind + resize-pane -U 10

          # switch panes using Alt-vim-arrow without prefix
          bind -n M-Left select-pane -L
          bind -n M-Right select-pane -R
          bind -n M-Up select-pane -U
          bind -n M-Down select-pane -D
      '';
    };
  };

  # FIXME The init.vim unconditionally installed by this module conflicts with
  # our init.lua, so we cannot use the module for now and must install the
  # configuration explicitly
  xdg.configFile.nvim = {
    source = ./config/neovim;
    recursive = true;
  };
  home.file.".config/alacritty/alacritty.toml".text = "
    # Live reload Alacritty config so it automatically responds to home-manager switches
    live_config_reload = true

    # Change Alacritty's default shell to home-manager's fish rather than the system default
    shell = \"${config.home.homeDirectory}/.nix-profile/bin/fish\"

    [font]
    size = 14.0
    [font.normal]
    family = \"FiraCode Nerd Font Mono\"
  ";
}
