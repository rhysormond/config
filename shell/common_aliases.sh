# shorthand
alias py="python"
alias bp="bpython"
alias ip="ipython"
alias jn="jupyter notebook"
alias tags="ctags -R ."
alias findfile="find . | grep"
alias findtext="grep -Gr"
alias ff="findfile"
alias ft="findtext"

# functions
cd() { builtin cd "$@" && ls; }

# pbcopy && pbpaste
if [[ $platform == 'linux' ]]; then
    alias alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
fi
