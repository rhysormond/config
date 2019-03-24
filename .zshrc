# zsh ls after every cd
function chpwd() {
    ls --color=auto
}

# source common shell config
source "$HOME/.shrc"
