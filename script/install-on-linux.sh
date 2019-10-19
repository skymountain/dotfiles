#!/bin/bash

DOTDIR=`dirname $0`
DOTDIR=$DOTDIR/..
DOTDIR=$(cd $DOTDIR && pwd)

ln -s $DOTDIR/emacs.d $HOME/.emacs.d
mkdir -p $HOME/.emacs.d/el-get 2> /dev/null
mkdir -p $HOME/.emacs.d/site-lisp 2> /dev/null

git config --global core.excludesfile $DOTDIR/git/gitignore
ln -s $DOTDIR/misc/aspell.conf $HOME/.aspell.conf
ln -s $DOTDIR/misc/keysnail.js $HOME/.keysnail.js
ln -s $DOTDIR/misc/imwheelrc $HOME/.imwheelrc

ln -s $DOTDIR/screen/screenrc $HOME/.screenrc
ln -s $DOTDIR/shell/zsh/zshrc $HOME/.zshrc

echo ''                             >> $HOME/.bash_profile
echo '# The following lines are inserted by the dot install script' \
                                    >> $HOME/.bash_profile
echo "export DOTDIR=$DOTDIR"        >> $HOME/.bash_profile
echo '. $DOTDIR/shell/bash/profile' >> $HOME/.bash_profile
echo '. $HOME/.bashrc'              >> $HOME/.bash_profile
echo '. $DOTDIR/shell/bash/bashrc'  >> $HOME/.bashrc
