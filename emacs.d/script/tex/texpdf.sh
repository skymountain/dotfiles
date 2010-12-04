#!/bin/bash

file=$1
platex $file && platex $file && dvipdfmx ${file%.*}
