#!/bin/bash


# If-Else Poritional Parameters
if [ "$1" == "start" ]; then 
    echo "Starting service"
elif [ "$1" == "stop" ]; then
    echo "Stopping service"
else
    echo "Usage: $0 {start|stop}"
fi

# File Tests
if [ -e test.sh1 ]; then
    echo "File exists"
elif [ -d /mnt/c/Users/vadzi/Tech/SystemEngineer/Scripting/Bash ]; then
    echo "Directory exists"
else
    echo "Not found"
fi

# Logical operatos &&(and) and ||(or) and ! (not)
var=10
if [[ "$var" -gt 5 ]] && [[ "$var" -lt 100 ]]; then 
    echo "Condition met: $var"
fi