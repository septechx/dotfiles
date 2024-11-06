#!/bin/bash

# Function to convert tmux timestamp to a human-readable date
format_date() {
  date -d "@$1" +"%Y-%m-%d %H:%M:%S"
}

# Get the list of tmux sessions with creation time and window count
sessions=$(tmux list-sessions -F "#{session_name} #{session_created} #{session_windows}" 2>/dev/null)

if [ -z "$sessions" ]; then
  # No sessions exist, create a new one
  echo "No tmux sessions found. Creating a new session..."
  tmux new-session
elif [ $(echo "$sessions" | wc -l) -eq 1 ]; then
  # Only one session exists, attach to it
  session_name=$(echo "$sessions" | awk '{print $1}')  # Extract the session name
  echo "One tmux session found. Attaching to it..."
  tmux attach-session -t "$session_name"
else
  # Multiple sessions exist, use fzf to select one
  echo "Multiple tmux sessions found. Select one to attach:"
  
  # Prepare a formatted list for fzf
  formatted_sessions=$(echo "$sessions" | while read -r session_name session_created session_windows; do
    readable_date=$(format_date "$session_created")
    echo "$session_name | Created: $readable_date | Windows: $session_windows"
  done)
  
  # Show the formatted list in fzf with a smaller layout
  selected=$(echo "$formatted_sessions" | gum choose --limit=1 --cursor.foreground="#000000")
  
  if [ -n "$selected" ]; then
    # Extract session name from the selected line
    session_name=$(echo "$selected" | cut -d '|' -f 1 | xargs)  # Trim whitespace
    tmux attach-session -t "$session_name"
  else
    echo "No session selected."
  fi
fi
