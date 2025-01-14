#!/bin/bash

# For Loop
echo "Loop #1"
for i in {1..5}; do 
    echo "Number: $i"
done

# C-style For Loop
echo "Loop #2"
for ((i=6;i <=10;i++)); do
    echo "Number: $i"
done

# While Loop
echo "While Loop"
count=1
while [ $count -le 3 ]; do
    echo "Iteration $count"
    ((count++))
done

# Until Loop
echo "Until Loop"
var=1
until [ $var -gt 3 ]; do 
    echo "Count: $var"
    ((var++))
done

# Loop files in a folder
for i in /mnt/c/Users/vadzi/Tech/SystemEngineer/Scripting/Bash/*.sh; do 
    echo "$i"
done

# Reading lines
while read -r line; do
    echo "$line"
done <1.Basics.sh

# Forever Loop
# while true; do
#     ...
# done
