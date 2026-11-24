#!/bin/zsh
# File: colors.zsh
# Version: 0.1
# Last Modified: 2018-03-23 23:13:47
# Author: Anton Chen
# Email: contact@antonchen.com

autoload -U colors && colors

# ls colors
# {{{
export LSCOLORS="Gxfxcxdxbxegedabagacad"
if command -v dircolors >/dev/null 2>&1; then
    eval "$(dircolors -b)"
fi

if [[ "$DISABLE_LS_COLORS" != "true" ]]; then
    ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
fi
# }}}

# 补全菜单颜色
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'
zstyle ':completion:*:corrections' format $'\e[01;32m -- %d (errors: %e) --\e[0m'

# command colors
# {{{
if [[ "$DISABLE_COMMAND_COLORS" != "true" ]]; then
    setopt extended_glob
    TOKENS_FOLLOWED_BY_COMMANDS=('|' '||' ';' '&' '&&' 'sudo' 'do' 'time' 'strace' 'man' 'xargs')

    recolor-cmd()
    {
    region_highlight=()
    colorize=true
    start_pos=0
    for arg in ${(z)BUFFER}; do
        ((start_pos+=${#BUFFER[$start_pos+1,-1]}-${#${BUFFER[$start_pos+1,-1]## #}}))
        ((end_pos=$start_pos+${#arg}))
        if $colorize; then
            colorize=false
            res=$(LC_ALL=C builtin type $arg 2>/dev/null)
            case $res in
                *'reserved word'*)
                    style="fg=magenta"
                    ;;
                *'alias for'*)
                    style="fg=cyan"
                    ;;
                *'shell builtin'*)
                    style="fg=yellow"
                    ;;
                *'shell function'*)
                    style="fg=green"
                    ;;
                *"$arg is"*)        
                    if [[ $arg = 'sudo' ]]; then 
                        style="fg=red,bold"
                    else
                        style="fg=blue"
                    fi
                    ;;
                *)
                    style="fg=red"
                    ;;
            esac
            region_highlight+=("$start_pos $end_pos $style")
        fi
        [[ ${${TOKENS_FOLLOWED_BY_COMMANDS[(r)${arg//|/\|}]}:+yes} = 'yes' ]]\
            && colorize=true
        start_pos=$end_pos
    done
}

check-cmd-self-insert() { zle .self-insert && recolor-cmd }
check-cmd-backward-delete-char() { zle .backward-delete-char && recolor-cmd }

zle -N self-insert check-cmd-self-insert
zle -N backward-delete-char check-cmd-backward-delete-char
fi
# }}}
