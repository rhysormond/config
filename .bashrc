# bash ls after every cd
cd() {
    builtin cd "$@" && ls --color=auto;
}

# source common shell config
source "$HOME/.shrc"
