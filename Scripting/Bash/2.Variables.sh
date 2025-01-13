#!/bin/bash

# Basic Variables
greet="How are you? "
user="Vadzim"
echo "I am happy to see you here, $user. $greet"

# Environment Variables
export GREETING="Hello"
bash -c "echo $GREETING"

# Read only Variables
readonly myvar="CannotChangeMe"

# Removes the variables
unset var

# Arithmetic Operations
x=10
y=200
sum=$((x+y)) 
echo "Sum: $sum"

# Positional parameters
echo "This is great $1 $2 $3"