#!/bin/bash

# Defining and Calling Functions
greet() {
    echo "Hello, $1"
    echo "How are you? "
}

greet $1

# Returning Values
add() {
    echo $(($1 + $2))
}

sum=$(add $2 $3)
echo "Sum: $sum"

# Global and Local Variables
myfunc() {
    local myvar="local"
    echo "$myvar"
}

myfunc


