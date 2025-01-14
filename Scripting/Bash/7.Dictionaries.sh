#!/bin/bash

# Defining Dictionaries
declare -A sounds

sounds[dog]="bark"
sounds[cow]="moo"
sounds[bird]="tweet"
sounds[wolf]="howl"

echo "${sounds[@]}" # All Values
echo "${sounds[wolf]}" 
echo "${!sounds[@]}" # All keys
echo "${#sounds[@]}" # Number of elements
unset sounds[dog]

# Iterate over values
for i in ${sounds[@]}; do
    echo $i
done

# Iterate over keys
for i in ${!sounds[@]}; do
    echo $i
done
