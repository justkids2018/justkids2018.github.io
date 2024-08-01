#!/bin/bash

# Check if the first argument is "true" or "false"
if [ "$1" = "true" ]; then
  INCLUDE_DRAFTS=true
else
  INCLUDE_DRAFTS=false
fi

# Base command
COMMAND="hugo server"

# Conditionally add --buildDrafts
if [ "$INCLUDE_DRAFTS" = true ]; then
  COMMAND="$COMMAND --buildDrafts"
fi
echo "Running command: ---------:$COMMAND"
# Run the command
$COMMAND