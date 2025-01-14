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

# Alternate way of defining function
function get_name() {
    echo "John"
}

echo "You are $(get_name)"


# Raising Errors
newfun() {
    return 1
}

if newfun; then
    echo "Success"
else
    echo "Failure"
fi

# Arguments
# $# 	Number of arguments
# $* 	All positional arguments (as a single word)
# $@ 	All positional arguments (as separate strings)
# $1 	First argument
# $_ 	Last argument of the previous command


