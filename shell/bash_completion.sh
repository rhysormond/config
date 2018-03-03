# tab completion
_pyenv() {
  COMPREPLY=()
  local word="${COMP_WORDS[COMP_CWORD]}"

  if [ "$COMP_CWORD" -eq 1 ]; then
    COMPREPLY=( $(compgen -W "$(pyenv commands)" -- "$word") )
  else
    local words=("${COMP_WORDS[@]}")
    unset words[0]
    unset words[$COMP_CWORD]
    local completions=$(pyenv completions "${words[@]}")
    COMPREPLY=( $(compgen -W "$completions" -- "$word") )
  fi
}

complete -F _pyenv pyenv

# init
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# prompt
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
