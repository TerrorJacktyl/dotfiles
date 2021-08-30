# Dotfiles repo

A repo for keeping dotfiles and command-line configuration files. You probably want to fork this repo then clone it on your machine into $HOME/dotfiles (i.e. run `git clone <repo-url>` from your home). Since you can only `git clone` into an _empty_ directory, you can symlink these files into your $HOME from $HOME/dotfiles instead as per below. Alternatively you can use the scripts in `scripts/`.

```bash
# clone repo into ~/dotfiles
git clone https://github.com/JayZ2398/dotfiles.git ~
# symlink dotfiles in home dir to repo dotfiles
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.bash_aliases ~/.bash_aliases
```

Then you can make your aliases take effect by opening up your terminal profile (i.e. `.bashrc`, `.zshrc`, etc.) and adding:

```bash
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
```
