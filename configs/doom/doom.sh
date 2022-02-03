DOOM_BIN_PATH="$HOME/.emacs.d/bin"

# install on mac
brew tap jimeh/emacs-builds
brew install --cask emacs-app-good
# add doom to path
if [[ ":$PATH:" == *":$DOOM_BIN_PATH:"* ]]; then
  echo "Your PATH contains doom."
else
  echo "Your path is missing doom, please add to your shell config (ie ~/.bashrc):\nexport PATH=$DOOM_BIN_PATH:\$PATH"
  exit
fi

# symlink the config in this repo to where your actual doom config should live
ln -s ~/dotfiles/configs/doom/.doom.d ~/.doom.d

# install notes for org
git clone git@github.com:JayZ2398/notes.git ~/git/notes

# run doom sync to load the config into emacs
doom sync
