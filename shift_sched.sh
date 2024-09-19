#!/bin/bash
user_prompt() {
  # Prompt for Name
  read -p "Name: " name

  # Prompt for Shift
  echo "Shift:"
  echo "1) Morning (6AM-3PM)"
  echo "2) Mid (2PM-11PM)"
  echo "3) Night (10PM-7AM)"
  read -p "Enter the number corresponding to your shift: " shift_choice

  case $shift_choice in
      1) shift="Morning" ;;
      2) shift="Mid" ;;
      3) shift="Night" ;;
      *) echo "Invalid selection. Please enter 1, 2, or 3." ; return ;;
  esac

  # Prompt for Team
  echo "Select your Team:"
  echo "1) A1"
  echo "2) A2"
  echo "3) A3"
  echo "4) B1"
  echo "5) B2"
  echo "6) B3"
  read -p "Enter the number corresponding to your team: " team_choice

  case $team_choice in
      1) team="A1" ;;
      2) team="A2" ;;
      3) team="A3" ;;
      4) team="B1" ;;
      5) team="B2" ;;
      6) team="B3" ;;
      *) echo "Invalid selection. Please enter a number between 1 and 6." ; return ;;
  esac

  # Display the input for now
  echo -e "\n--- User Input ---"
  echo "Name: $name"
  echo "Shift: $shift"
  echo "Team: $team"
  echo "-------------------"
}

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

user_prompt
print_table
