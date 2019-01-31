# bash ls after every cd
cd() { builtin cd "$@" && ls; }

# source common shell config
source "$HOME/.shrc"
