# Add local variables, functions, etc.
if [[ -r ~/.bashrc_local ]]; then
    . ~/.bashrc_local
fi

# Add aliases
if [[ -f ~/.bash_aliases ]]; then
    . ~/.bash_aliases
fi

# Add go executables to the path
GOPATH="$HOME/go/bin"
if [[ -d $GOPATH ]]; then
    PATH=$GOPATH:$PATH
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
