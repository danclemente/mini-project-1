#!/bin/bash
user_prompt() {
  # Prompt for Name
  read -p "Name: " name

  while true; do
    # Prompt for Shift
    echo "Shift:"
    echo "1) Morning (6AM-3PM)"
    echo "2) Mid (2PM-11PM)"
    echo "3) Night (10PM-7AM)"
    read -p "Enter the number corresponding to your shift: " shift_choice

    case $shift_choice in
        1) shift="morning" ;;
        2) shift="mid" ;;
        3) shift="night" ;;
        *) echo "Invalid selection. Please enter 1, 2, or 3." ; continue ;;  # Loop again if invalid
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
        *) echo "Invalid selection. Please enter a number between 1 and 6." ; continue ;;  # Loop again if invalid
    esac

    # Path to the count file
    count_file="Database/$team/$shift/count"

    # Read the current count
    current_count=$(cat "$count_file")

    # Check if the shift is already full
    if [ "$current_count" -ge 2 ]; then
      echo "Error: This shift for team $team is already full. Only 2 people allowed per shift."
      echo "Please select a different shift or team."
      continue  # Restart the loop if the shift is full
    fi

    # If the shift is not full, break the loop
    break
  done

  # Increment the count and add the user to the list
  ((current_count++))
  echo "$current_count" > "$count_file"   # Update the count file

  # Add the user to the list file
  echo "$name, $shift, $time" >> "Database/$team/$shift/list"

  # Display 
  echo -e "\n--- User Added Successfully ---"
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
