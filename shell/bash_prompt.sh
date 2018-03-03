# git functions
get_git_remote()
{
  basename 2> /dev/null -s .git \
    $(git remote -v 2> /dev/null |
      grep origin |
      grep fetch |
      awk '{print $2}')
}
get_git_status()
{
  local git_status="`git status -unormal 2>&1`"
  if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
    if ! [[ "$git_status" =~ Untracked\ files ]]; then
      echo -e "$GREEN:$DEFAULT"
    else
      echo -e "$RED:$DEFAULT"
    fi
  else
    echo -e ":"
  fi
}
get_git_branch()
{
  local branch="`git branch 2> /dev/null | grep \* | sed "s/\*[[:space:]]//g"`"
  local git_status="`git status -unormal 2>&1`"
  if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
    if [[ "$git_status" =~ nothing\ to\ commit ]]; then
      echo -e $GREEN$branch$DEFAULT
    elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
      echo -e $RED$branch$DEFAULT
    else
      echo -e $YELLOW$branch$DEFAULT
    fi
  fi
}
get_venv()
{
  VENV_NAME="$(pyenv version-name)"
  VENV_NAME="${VENV_NAME##*/}"
  COLOR="$BLUE"
  [ "${VIRTUAL_ENV##*/}" == "$VENV_NAME" ] && COLOR="$GREEN"
  if [[ "${VENV_NAME}" == "system" ]]; then
    echo -e ""
  else
    echo -e "$COLOR${VENV_NAME}$DEFAULT"
  fi
}

venv_prompt="\$(get_venv)-"
git_prompt="$GREEN\$(get_git_remote)$DEFAULT\$(get_git_status)\$(get_git_branch)"
export PS1="$MAGENTA\h$DEFAULT \w ($venv_prompt$git_prompt)\n> "
export PS2="> "
