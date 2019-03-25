# aliases
alias g="git"
alias config="git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# autojump support
begin
    set --local AUTOJUMP_PATH "/usr/share/autojump/autojump.fish"
    if test -e $AUTOJUMP_PATH
        source $AUTOJUMP_PATH
    end
end

# add ~/bin to $PATH
set -x PATH "$HOME/bin" $PATH

# os-specific configuration
switch (uname)
    case Linux
        alias pbcopy="xsel --clipboard --input"
        alias pbpaste="xsel --clipboard --output"
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

# prompt
function fish_prompt
    set_color blue
    printf "%s" (prompt_pwd)
    set_color normal
    printf "%s" (__fish_git_prompt)
    set_color purple
    printf " > "
    set_color normal
end

# reuse common env vars
# from https://gist.github.com/overtrue/f7cd321708ba917b8def
egrep "^export " ~/.env | while read e
    set var (echo $e | sed -E "s/^export ([A-Za-z_]+)=(.*)\$/\1/")
    set value (echo $e | sed -E "s/^export ([A-Za-z_]+)=(.*)\$/\2/")

    # remove surrounding quotes if existing
    set value (echo $value | sed -E "s/^\"(.*)\"\$/\1/")

    if test $var = "PATH"
        # replace ":" by spaces. this is how PATH looks for Fish
        set value (echo $value | sed -E "s/:/ /g")

        # use eval because we need to expand the value
        eval set -xg $var $value

        continue
    end

    # evaluate variables. we can use eval because we most likely just used "$var"
    set value (eval echo $value)

    #echo "set -xg '$var' '$value' (via '$e')"
    set -xg $var $value
end
