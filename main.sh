#!/bin/bash

command="$1"
alias_name="$2"

save() {
  local name="$1"
  echo "$name,$PWD" >> "$HOME/.wd/wd.conf"
}

delete() {
  local name="$1"
  echo "deleting alias $name"
}

update() {
  local name="$1"
  echo "updating alias $name"
}

$command $alias_name 
