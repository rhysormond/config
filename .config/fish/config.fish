# aliases
alias g="git"
alias pbcopy="xsel --clipboard --input"
alias pbpaste="xsel --clipboard --output"

function jd --argument file1 --argument file2 --description 'jq, sort, and diff two json files'
    command diff (jq "." -S < $file1 | psub) (jq "." -S < $file2 | psub)
end

function pk --description "fzy for a process and kill it"
    set pid (ps -ef | sed 1d | fzy | awk '{print $2}')

    if test -n "$pid"
        command kill -9 $pid
    end
end

function man --description "wrap man to color output without changing less"
    set -x LESS_TERMCAP_mb (set_color brred)
    set -x LESS_TERMCAP_md (set_color brred)
    set -x LESS_TERMCAP_me (set_color normal)
    set -x LESS_TERMCAP_se (set_color normal)
    set -x LESS_TERMCAP_so (set_color -b blue bryellow)
    set -x LESS_TERMCAP_ue (set_color normal)
    set -x LESS_TERMCAP_us (set_color brgreen)
  command man $argv
end

# vi mode key bindings
fish_vi_key_bindings

# vi mode prompt
function fish_mode_prompt --description "Displays the current vi mode"
    if test "$fish_key_bindings" = "fish_vi_key_bindings"
        switch $fish_bind_mode
            case default
                set_color --bold purple
                echo "N"
            case insert
                set_color --bold green
                echo "I"
            case replace_one
                set_color --bold red
                echo "R"
            case visual
                set_color --bold grey
                echo "V"
        end
        set_color normal
        printf " "
    end
end

# git status colors
set __fish_git_prompt_color normal
set __fish_git_prompt_color_branch yellow

# git status state
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'

# git status chars
set __fish_git_prompt_char_untrackedfiles '☡'
set __fish_git_prompt_char_dirtystate '✗'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '↑'
set __fish_git_prompt_char_upstream_behind '↓'

# left prompt
function fish_prompt
    set_color blue
    printf "%s" (prompt_pwd)
    set_color normal
    printf "%s" (__fish_git_prompt)
    set_color purple
    printf " > "
    set_color normal
end

# right prompt
function fish_right_prompt
    set_color grey
    printf "%s" (hostname)
    set_color normal
end

# system-specific env vars
source $HOME/.env

# set tty for gpg
set -x GPG_TTY (tty)
