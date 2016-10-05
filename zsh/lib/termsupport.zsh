#!/bin/zsh
# File: termsupport.zsh
# Description: 
# Version: 0.1
# Create Date: 2016-08-08 14:41
# Last Modified: 2016-09-24 10:51
# Author: Anton Chen
# Email: contact@antonchen.com
function title {
    emulate -L zsh
    setopt prompt_subst
    [[ "$EMACS" == *term* ]] && return
    : ${2=$1}
    case "$TERM" in
        cygwin|xterm*|putty*|rxvt*|ansi)
            print -Pn "\e]2;$2:q\a" # set window name
            print -Pn "\e]1;$1:q\a" # set tab name
            ;;
        screen*)
            print -Pn "\ek$1:q\e\\" # set screen hardstatus
            ;;
        *)
            if [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
                print -Pn "\e]2;$2:q\a" # set window name
                print -Pn "\e]1;$1:q\a" # set tab name
            else
                if [[ -n "$terminfo[fsl]" ]] && [[ -n "$terminfo[tsl]" ]]; then
                    echoti tsl
                    print -Pn "$1"
                    echoti fsl
                fi
            fi
            ;;
    esac
}

ZSH_THEME_TERM_TAB_TITLE_IDLE="%15<..<%~%<<" #15 char left truncated PWD
ZSH_THEME_TERM_TITLE_IDLE="%n@%m: %~"

if [[ "$TERM_PROGRAM" == Apple_Terminal ]]; then
    ZSH_THEME_TERM_TITLE_IDLE="%n@%m"
fi

function omz_termsupport_precmd {
    emulate -L zsh
    if [[ "$DISABLE_AUTO_TITLE" == true ]]; then
        return
    fi
    title $ZSH_THEME_TERM_TAB_TITLE_IDLE $ZSH_THEME_TERM_TITLE_IDLE
}

function omz_termsupport_preexec {
    emulate -L zsh
    setopt extended_glob
    if [[ "$DISABLE_AUTO_TITLE" == true ]]; then
        return
    fi
    local CMD=${1[(wr)^(*=*|sudo|ssh|mosh|rake|-*)]:gs/%/%%}
    local LINE="${2:gs/%/%%}"
    title '$CMD' '%100>...>$LINE%<<'
}

precmd_functions+=(omz_termsupport_precmd)
preexec_functions+=(omz_termsupport_preexec)

if [[ "$TERM_PROGRAM" == "Apple_Terminal" ]] && [[ -z "$INSIDE_EMACS" ]]; then
    function update_terminalapp_cwd() {
        emulate -L zsh

        local URL_PATH="$(omz_urlencode -P $PWD 2>/dev/null)"
        [[ $? != 0 ]] && return 1

        printf '\e]7;%s\a' "file://$HOST$URL_PATH"
    }
    precmd_functions+=(update_terminalapp_cwd)
    update_terminalapp_cwd
fi
