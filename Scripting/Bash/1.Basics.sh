#!/bin/bash

# Bash Strict Mode (Error Handling)
# Catch errors and undefined variables
set -euo pipefail
IFS=$'\n\t'


echo "Welcome to Bash Scripting!"



# Make this script executable chmod +x file.sh
: '
#! /bin/bash -> Bash interpreter
#! /bin/sh -> Shell interpreter
#! /bin/dash -> Ubuntu interpreter (which is faster but lacks some advanced bash features)
#! /usr/bin/env python3 -> Use for scripts written in Python
#! /usr/bin/perl -> Using for Perl scripting
#! /usr/bin/env node -> Using for JavaScript server-side scripting

'
