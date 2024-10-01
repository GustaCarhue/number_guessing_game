#!/bin/bash

# Generar un número aleatorio entre 1 y 1000
secret_number=$(( RANDOM % 1000 + 1 ))
number_of_guesses=0

echo "¡Bienvenido al juego de adivinanza de números!"
echo "Adivina el número secreto entre 1 y 1000:"

# Bucle principal del juego
while true; do
    read -p "Introduce tu adivinanza: " guess
    number_of_guesses=$((number_of_guesses + 1))

    # Validación del rango
    if (( guess < 1 || guess > 1000 )); then
        echo "Por favor, introduce un número entre 1 y 1000."
        continue  # Volver al inicio del bucle
    fi

    if [[ ! "$guess" =~ ^[0-9]+$ ]]; then
        echo "Eso no es un número entero, intenta de nuevo."
    elif (( guess < secret_number )); then
        echo "Es más alto, intenta de nuevo."
    elif (( guess > secret_number )); then
        echo "Es más bajo, intenta de nuevo."
    else
        echo "¡Adivinaste en $number_of_guesses intentos! El número secreto era $secret_number."
        break
    fi
done
