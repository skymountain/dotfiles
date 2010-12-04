#!/bin/bash

if [ -z "$EMACS" ]; then
  EMACS='emacs'
fi
if [ -z "$EMACSCLIENT" ]; then
  EMACSCLIENT='emacsclient'
fi

`ps -f -u $USER | grep "$EMACS --daemon" | grep --silent -v 'grep'`;
if [ $? -ne 0 ]; then
  `"$EMACS" --daemon`;
fi

"$EMACSCLIENT" -c $*
