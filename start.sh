#!/bin/bash

# Iterate over all directories containing "Bot" in their names
for dir in *Bot*/; do
  # Check if the directory contains the "launch" executable
  if [[ -d "$dir" && -x "${dir}launch" ]]; then
    # Get the directory name without the trailing slash
    session_name=$(basename "$dir")
    
    # Create a new tmux session named after the directory
    tmux new-session -d -s "$session_name"
    
    # Run the "launch" executable within the new tmux session
    tmux send-keys -t "$session_name" "cd $(realpath "$dir") && ./launch" C-m
  else
    echo "No executable 'launch' found in $dir"
  fi
done
