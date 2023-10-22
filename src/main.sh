#!/bin/bash

command="$1"
alias_name="$2"

save() {
  local name=$1
  echo "$name,$PWD" >> $HOME/.wd/wd.conf
}

delete() {
  local name=$1
  echo "deleting alias $name"
}

update() {
  local name=$1
  echo "updating alias $name"
}

list() {
  awk -F "," '{ 
    printf "%-10s %-10s\n", $1, $2
  }' $HOME/.wd/wd.conf
}

usage() {
  echo "Usage: wd ([command]) [alias]"
  echo "Commands:"
  echo "  save [alias] - save current directory as alias"
  echo "  delete [alias] - delete alias"
  echo "  update [alias] - update alias"
  echo "  list - list all aliases"
  echo "  [alias] - cd to alias"
}

directory="$(awk -v command="$command" -v alias_name="$alias_name" -F "," '{ 
  if ($1 == command) {
    print $2
  }
}' $HOME/.wd/wd.conf)"

if [[ $command == "update" || $command == "save" || $command == "delete" ]]; then
  reserved_commands_condition=1
else
  reserved_commands_condition=0
fi

if [[ $# -eq 1 ]]; then
  if [[ $command == "list" ]]; then
    list
  elif [[ $reserved_commands_condition -eq 0 ]]; then
    if [[ $directory ]]; then
      cd $directory
    else
      cd $command
    fi
  else
    echo $command "expects an argument [alias]"
    echo "---"
    usage
  fi
elif [[ $# -eq 2 && $reserved_commands_condition ]]; then
  if [[ $directory ]]; then
    $command $alias_name
  else
    echo "Alias $alias_name does not exist"
  fi
else
  usage
fi

unset -f save delete update list usage
