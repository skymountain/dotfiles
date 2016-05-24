#!/bin/bash

DOTDIR=`dirname $0`
DOTDIR=$DOTDIR/..
DOTDIR=$(cd $DOTDIR && pwd)

ln -s $DOTDIR/emacs.d $HOME/.emacs.d
ln -s $DOTDIR/git/gitignore $HOME/.gitignore
ln -s $DOTDIR/misc/aspell.conf $HOME/.aspell.conf
ln -s $DOTDIR/misc/keysnail.js $HOME/.keysnail.js
ln -s $DOTDIR/screen/screenrc $HOME/.screenrc
ln -s $DOTDIR/shell/zsh/zshrc $HOME/.zshrc

ln -s $DOTDIR/mac/DefaultKeyBinding.dict $HOME/Library/KeyBindings/
ln -s $DOTDIR/mac/private.xml "$HOME/Library/Application Support/Karabiner/"
