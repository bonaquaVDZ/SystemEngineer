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


# Conditions
# [[ -z STRING ]] -> Empty String
# [[ -n STRING ]] -> Not Empty String
# [[ STRING == STRING]] or [[ STRING != STRING ]] -> Equal or Not Equal
# [[ -eq -ne -lt -le -gt -ge ]]
# [[ STRING =~ STRING ]] -> Regexp
# (( NUM < NUM )) -> Numeric conditions
# [[ -o noclobber ]] -> if OPTIONNAME is enabled
# [[ ! EXPR ]] -> Not
# [[ X && Y ]] -> And
# [[ X || Y ]] -> Or

# File Conditions 
# [[ -e FILE ]] -> Exists
# [[ -r FILE ]] -> Readable
# [[ -h FILE ]] -> Symlink
# [[ -d FILE ]] -> Directory
# [[ -w FILE ]] -> Writable
# [[ -s FILE ]] -> Size is > 0 bytes
# [[ -f FILE ]] -> File
# [[ -x FILE ]] -> Executable
# [[ FILE1 -nt FILE2 ]] -> 1 is more recent than 2
# [[ FILE1 -ot FILE2 ]] -> 2 is more recent than 2
# [[ FILE1 -ef FILE2 ]] -> Same files 