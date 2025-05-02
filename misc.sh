# misc details to add later on

#!/bin/bash

# ANSI color codes
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Define the command to run
command_to_run="ls -l --color=never"

# Print the command being run
echo -e "${GREEN}Running: $command_to_run${NC}"

# Run the command and color its output green
eval "$command_to_run" | while IFS= read -r line; do
    echo -e "${GREEN}${line}${NC}"
done
