# history navigation with arrow keys
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# append to history, don't overwrite it
shopt -s histappend

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
