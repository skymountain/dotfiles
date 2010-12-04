#!/bin/bash

if [ -n "$DISPLAY" ]; then
  unison-gtk
else
  unison-text
fi
