# Dotfiles repo

Keep your dotfiles in this repo. You probably want to clone this repo on your machine and then put the dotfiles into your home directory. Since you can only `git clone` into an _empty_ directory, you can symlink these files instead:

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
