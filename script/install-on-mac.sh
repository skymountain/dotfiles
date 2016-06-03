#!/bin/bash

DOTDIR=`dirname $0`
DOTDIR=$DOTDIR/..
DOTDIR=$(cd $DOTDIR && pwd)

ln -s $DOTDIR/emacs.d $HOME/.emacs.d
mkdir -p $HOME/.emacs.d/el-get

git config --global core.excludesfile $DOTDIR/git/gitignore
ln -s $DOTDIR/misc/aspell.conf $HOME/.aspell.conf
ln -s $DOTDIR/misc/keysnail.js $HOME/.keysnail.js

ln -s $DOTDIR/screen/screenrc $HOME/.screenrc
ln -s $DOTDIR/shell/zsh/zshrc $HOME/.zshrc

mkdir -p $HOME/Library/KeyBindings 2> /dev/null
if [ -e $HOME/Library/KeyBindings/DefaultKeyBinding.dict ]; then
  cp $HOME/Library/KeyBindings/DefaultKeyBinding.dict $HOME/Library/KeyBindings/DefaultKeyBinding.dict.old
fi
cp $DOTDIR/mac/DefaultKeyBinding.dict $HOME/Library/KeyBindings/DefaultKeyBinding.dict

mkdir -p "$HOME/Library/Application Support/Karabiner" 2> /dev/null
ln -s $DOTDIR/mac/private.xml "$HOME/Library/Application Support/Karabiner"
