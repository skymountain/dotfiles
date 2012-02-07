#!/bin/bash

function filter-tex {
  ott=$1
  tex=$2
  suffix=$3

  input=${ott%.*}.tex

  echo "OTT FROM: $tex TO: ${tex%.*}$suffix"

  ott                    \
    -i $ott              \
    -o $input            \
    -tex_show_meta false \
    -tex_name_prefix ott \
    -tex_wrap false      \
    -tex_filter "$tex" "${tex%.*}$suffix"

  return $?
}

function bib {
  res=0

  gres=`grep 'bibliography' "$1.tex" 2> /dev/null` 2> /dev/null

  if [ "$gres" ]; then
    echo "COMPILE BIBTEX: $1 ..."
    bibtex $1
    res=$?
  fi

  if [ $res -ne 0 ]; then
    echo "BIB COMPILE WAS FAILED!"
  else
    echo "BIB COMPILE WAS SUCCESS!"
  fi

  return $res
}

file=$1
dir=$PWD
ott=$dir/*.ott

if [ -f $ott ]; then
  suffix='.ott.tex'
  filter-tex $ott $file $suffix
  if [ $? -ne 0 ]; then
    exit $?
  fi

  file=${file%.*}$suffix
fi

base=${file%.*}
dvifile=$base.dvi
psfile=$base.ps

platex $file && bib $base && platex $file && platex $file && dvips -P pdf $dvifile && ps2pdf $psfile
