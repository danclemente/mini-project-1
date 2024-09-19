#!/bin/bash

#Prints table
print_table() {
  for team in $(ls Database)
  do
    echo "$team"  
    for shift in $(ls Database/$team)
    do
      echo -e "\t $shift"
      for line in $(cat Database/$team/$shift/list)
      do
        echo -e "\t\t $line"
      done
    done
  done
}

print_table