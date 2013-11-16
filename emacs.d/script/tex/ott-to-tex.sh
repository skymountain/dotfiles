#!/bin/bash

function ott-to-input {
  src=$1
  dst=$2

  # cp $src $dst

  # sed -e s/^\documentclass{.*$// $dst  > $dst
  # sed -e s/^\begin{document}.*$// $dst > $dst
  # sed -e s/^\end{document}.*$// $dst   > $dst
}

dir=${0%/*}
base=${1%.*}

ottfile=$base.ott
texfile=$base.ott.tex
dvifile=$base.ott.dvi
psfile=$base.ott.ps

inputfile=$base.tex

ott -i "$ottfile" -o "$texfile" && platex $texfile && platex $texfile && dvips -P pdf $dvifile && ps2pdf $psfile && ott-to-input $texfile $inputfile
