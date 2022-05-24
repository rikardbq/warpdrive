#!/bin/bash

echo "Running warpdrive installation"

dir="$HOME/.wd"
conf_file="$HOME/.wd/wd.conf"
if [[ ! -d $dir ]]
then
  echo "creating directory $dir"
  mkdir "$dir"
fi
if [[ ! -f $conf_file ]]
then
  echo "creating file $conf_file"
  touch "$conf_file"
fi

echo "copying main script"
cp ./main.sh "$dir/wd.sh"
echo "making main script executable"
chmod +x "$dir/wd.sh"

echo "alias wd='$dir/wd.sh'" >> "$HOME/.bashrc"
source $HOME/.bashrc
