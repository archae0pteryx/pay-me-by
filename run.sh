#!/bin/bash

if [ ! -e ./.git ]; then
  echo "not a git repository"
elif [ ! -e "$1" ]; then
  echo "cant find index.html file"
elif [ ! "$2" ]; then
  echo "please supply a date"
else
  node ./script/index.js "$1" "$2"
fi
