#!/bin/bash

# Prompt the user for a username
read -p "Enter your username: " username

# Validate that the username does not exceed 22 characters
if [ ${#username} -gt 22 ]; then
    echo "The username cannot be more than 22 characters."
    exit 1
fi

# Simulate database (you can replace this with your database logic)
declare -A user_data  # Create an associative array to store user data

# Check if the user has played before
if [[ -v user_data["$username"] ]]; then
    # Existing user
    games_played=${user_data["$username,games_played"]}
    best_game=${user_data["$username,best_game"]}
    echo "Welcome back, $username! You have played $games_played games, and your best game took $best_game guesses."
else
    # New user
    echo "Welcome, $username! It looks like this is your first time here."
    # Initialize user data in the "database"
    user_data["$username,games_played"]=0
    user_data["$username,best_game"]=999  # A high number to compare
fi

# Generate a random number between 1 and 1000
secret_number=$(( RANDOM % 1000 + 1 ))
number_of_guesses=0

echo "Guess the secret number between 1 and 1000:"

# Main game loop
while true; do
    read -p "Introduce your guess: " guess
    number_of_guesses=$((number_of_guesses + 1))

    # Validate the input
    if [[ ! "$guess" =~ ^[0-9]+$ ]]; then
        echo "That is not an integer, guess again:"
        continue
    fi

    # Validate the range
    if (( guess < 1 || guess > 1000 )); then
        echo "Please enter a number between 1 and 1000."
        continue  # Return to the beginning of the loop
    fi

    # Compare the guess with the secret number
    if (( guess < secret_number )); then
        echo "It's higher than that, guess again:"
    elif (( guess > secret_number )); then
        echo "It's lower than that, guess again:"
    else
        echo "You guessed it in $number_of_guesses tries. The secret number was $secret_number. Nice job!"
        
        # Update user data
        user_data["$username,games_played"]=$((user_data["$username,games_played"] + 1))
        if (( number_of_guesses < user_data["$username,best_game"] )); then
            user_data["$username,best_game"]=$number_of_guesses
        fi
        break
    fi
done

