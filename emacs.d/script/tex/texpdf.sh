#!/bin/bash

file=$1
dvifile=${file%.*}.dvi
psfile=${file%.*}.ps

platex $file && platex $file && dvips -P pdf $dvifile && ps2pdf $psfile
