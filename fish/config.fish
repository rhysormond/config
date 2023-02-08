# set tty for gpg
set -x GPG_TTY (tty)

# aliases
alias g="git"
alias v="vi"
alias vi="vim"
alias vim="nvim"

function jd --argument file1 --argument file2 --description 'jq, sort, and diff two json files'
  command git diff (jq "." -S < $file1 | psub) (jq "." -S < $file2 | psub)
end

function jq-inplace --argument file --description 'format a file with jq in place'
  command jq < $file > temp.json
  mv temp.json $file
end

function pk --description "fzy for a process and kill it"
  set pid (ps -ef | sed 1d | fzf | awk '{print $2}')

  if test -n "$pid"
    command kill -9 $pid
  end
end

# vi mode prompt
function fish_mode_prompt --description "Displays the current vi mode"
  if test "$fish_key_bindings" = "fish_vi_key_bindings"
    switch $fish_bind_mode
      case default
        set_color --bold purple
        echo "N"
      case insert
        set_color --bold brgreen
        echo "I"
      case replace_one
        set_color --bold brred
        echo "R"
      case visual
        set_color --bold grey
        echo "V"
    end
    set_color normal
    printf " "
  end
end

# left prompt
function fish_prompt
  # set first so this isn't overwritten by other downstream calls
  set -l last_status $status

  # print the current working directory
  set_color blue
  printf "%s" (prompt_pwd)

  # print git information
  set_color normal
  printf "%s" (fish_git_prompt)

  # print the delimiter along with an error code if the last command failed
  if [ $last_status -ne 0 ]
    set_color brred
    printf " |$last_status> "
  else
    set_color --bold purple
    printf " |> "
  end

  set_color normal
end

# system-specific env vars
source $HOME/.env
