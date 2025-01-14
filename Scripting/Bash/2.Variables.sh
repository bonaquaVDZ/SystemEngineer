#!/bin/bash

# Basic Variables
greet="How are you? "
user="Vadzim"
echo "I am happy to see you here, $user. $greet"

wildcard="*.txt"
options="iv"
cp -$options $wildcard /TestFolder

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

# Parameter expansions
name="John"
echo "${name/J/j}" # -> "john" substitution
echo "${name:0:2}" # -> "Jo" slicing
echo "${name::-1}" # -> "Joh" slicing
echo "${name:(-1)}" # -> "n" (slicing from right)
echo "${food:-Cake}" # -> $food or "Cake"

str="/path/to/foo.cpp"
echo "${str%.cpp}" # -> /path/to/foo
echo "${str%.cpp}.o" # -> /path/to/foo.o
echo "${str%/*}" # /path/to

echo "${str##*.}" # cpp (extension)
echo "${str##*/}" # foo.cpp (basepath)
echo "${str/foo/bar}" # /path/to/bar.cpp

src="/path/to/foo.cpp"
base=${src##*/} # foo.cpp (basepath)
dir=${src%$base} # /path/to/ (dirpath)

# Indirection
name=joe
pointer=name
echo ${!pointer} # joe

# Substitution
# ${foo%suffix} 	Remove suffix
# ${foo#prefix} 	Remove prefix
# ${foo%%suffix} 	Remove long suffix
# ${foo/%suffix} 	Remove long suffix
# ${foo##prefix} 	Remove long prefix
# ${foo/#prefix} 	Remove long prefix
# ${foo/from/to} 	Replace first match
# ${foo//from/to} 	Replace all
# ${foo/%from/to} 	Replace suffix
# ${foo/#from/to} 	Replace prefix


# Manipulation
str="HELLO WORLD"
echo "${str,}" # Lowercase first letter
echo "${str,,}" # All lowercase

str="hello world"
echo "${str^}" # Uppercase first letter
echo "${str^^}" # All uppercase

# Default Values
# ${foo:-val} 	$foo, or val if unset (or null)
# ${foo:=val} 	Set $foo to val if unset (or null)
# ${foo:+val} 	val if $foo is set (and not null)
# ${foo:?message} 	Show error message and exit if $foo is unset (or null)