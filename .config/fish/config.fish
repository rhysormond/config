# aliases
alias g="git"
alias pbcopy="xsel --clipboard --input"
alias pbpaste="xsel --clipboard --output"

# make tmux respect XDG standard; this can be removed once tmux 3.1 is released
alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"

# diff utils
function jd --argument file1 --argument file2 --description 'jq, sort, and diff two json files'
    command diff (jq "." -S < $file1 | psub) (jq "." -S < $file2 | psub)
end

# fuzzy selection utils
function rv --argument pattern --description 'rg a pattern, fzy the results, and open in vim'
    if not test -n "$pattern"
        set pattern .
    end

    set file_and_number (rg -i --line-number $pattern | fzy | cut -d ":" -f-2)

    if test -n "$file_and_number"
        set file (echo $file_and_number | cut -d ":" -f1)
        set number (echo $file_and_number | cut -d ":" -f2)
        command vim +$number $file
    end
end

function pk --description "fzy for a process and kill it"
    set pid (ps -ef | sed 1d | fzy | awk '{print $2}')

    if test -n "$pid"
        command kill -9 $pid
    end
end


# colored man output
# from http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
setenv LESS_TERMCAP_mb \e"[01;31m"       # begin blinking
setenv LESS_TERMCAP_md \e"[01;38;5;74m"  # begin bold
setenv LESS_TERMCAP_me \e"[0m"           # end mode
setenv LESS_TERMCAP_se \e"[0m"           # end standout-mode
setenv LESS_TERMCAP_so \e"[38;5;246m"    # begin standout-mode - info box
setenv LESS_TERMCAP_ue \e"[0m"           # end underline
setenv LESS_TERMCAP_us \e"[04;38;5;146m" # begin underline

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
