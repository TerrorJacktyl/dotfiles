# Dotfiles

This is my reproducible developer environment. It uses [home-manager][home-manager]—a [Nix][nix]-based tool—to install programs and create their configuration files based off the [`home.nix`](home.nix) file in this repository. I stole it from someone who [wrote more about it in a blog post][nix-post].

## Usage

Install [Nix][nix], enable Nix Flake support, and then install [home-manager]
[home-manager]. You should be able to run `home-manager` program in a shell.

If you've cloned this repo at `~/dotfiles`, you should be able to reload the latest changes in your shell with with:

```shell
$ home-manager -f ~/dotfiles/home.nix switch
```

### Fish

I like to set [fish][fish] as my default shell. On macOS this means:

1. Editing `/etc/shells` to include an entry for the home-manager-managed
   `fish` binary at `~/.nix-profile/bin/fish`.
2. Setting the default shell with `chsh -s ~/.nix-profile/bin/fish`.

### Neovim

I'm in the process of figuring this out. You should be able to load my config and open `neovim`, or just pinch the `config/neovim` folder to use it outside of nix.

[nix]: https://nixos.org/
[home-manager]: https://github.com/nix-community/home-manager
[fish]: https://fishshell.com/
[neovim]: https://neovim.io/
[nix-post]: https://alexpearce.me/2021/07/managing-dotfiles-with-nix/
