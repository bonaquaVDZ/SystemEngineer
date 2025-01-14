#!/bin/bash

# Numeric calculations
echo $((a+200))
echo $((RANDOM%100))
declare -i count # Declare as type integer
count+=1         # Increment
echo $count


# Redirection
python hello.py > output.txt            # stdout to (file)
python hello.py >> output.txt           # stdout to (file), append
python hello.py 2> error.log            # stderr to (file)
python hello.py 2>&1                    # stderr to stdout
python hello.py 2>/dev/null             # stderr to (null)
python hello.py >output.txt 2>&1        # stdout and stderr to (file), equivalent to &>
python hello.py &>/dev/null             # stdout and stderr to (null)
echo "$0: warning: too many users" >&2  # print diagnostic message to stderr

# Transform strings
# -c 	Operations apply to characters not in the given set
# -d 	Delete characters
# -s 	Replaces repeated characters with single occurrence
# -t 	Truncates
# [:upper:] 	All upper case letters
# [:lower:] 	All lower case letters
# [:digit:] 	All digits
# [:space:] 	All whitespace
# [:alpha:] 	All letters
# [:alnum:] 	All letters and digits
echo "Welcome to The Earth" | tr '[:lower:]' '[:upper:]'


# Inspecting commands
command -V cd

# Check for commands result
if ping -c 1 google.com; then
  echo "It appears you have a working internet connection"
fi

# Grep check
if grep -q 'foo' ~/.bash_history; then
  echo "You appear to have typed 'foo' in the past"
fi

# Reading input
echo -n "Proceed? [y/n]: "
read -r ans
echo "$ans"






history

# Expansions
# !$ 	Expand last parameter of most recent command
# !* 	Expand all parameters of most recent command
# !-n 	Expand nth most recent command
# !n 	Expand nth command in history
# !<command> 	Expand most recent invocation of command <command>

# Operations
# !! 	Execute last command again
# !!:s/<FROM>/<TO>/ 	Replace first occurrence of <FROM> to <TO> in most recent command
# !!:gs/<FROM>/<TO>/ 	Replace all occurrences of <FROM> to <TO> in most recent command
# !$:t 	Expand only basename from last parameter of most recent command
# !$:h 	Expand only directory from last parameter of most recent command

# !! and !$ can be replaced with any valid expansion.

# Slices
# !!:n 	Expand only nth token from most recent command (command is 0; first argument is 1)
# !^ 	Expand first argument from most recent command
# !$ 	Expand last token from most recent command
# !!:n-m 	Expand range of tokens from most recent command
# !!:n-$ 	Expand nth token to last from most recent command

# !! can be replaced with any valid expansion i.e. !cat, !-2, !42, etc.