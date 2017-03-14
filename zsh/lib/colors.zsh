#!/bin/zsh
# File: colors.zsh
# Description: 
# Version: 0.1
# Create Date: 2016-07-20 14:08
# Last Modified: 2017-01-09 12:09
# Author: Anton Chen
# Email: contact@antonchen.com

autoload -U colors && colors

# ls colors
# {{{
if dircolors -b >/dev/null 2>&1; then
	export LSCOLORS=$LS_COLORS
else
	export LSCOLORS="Gxfxcxdxbxegedabagacad"
fi

if  [ "$DISABLE_LS_COLORS" != "true" ]; then
	ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
fi
# }}}

# command colors
# {{{
if [ "$DISABLE_COMMAND_COLORS" != "true" ]; then
    setopt extended_glob
    TOKENS_FOLLOWED_BY_COMMANDS=('|' '||' ';' '&' '&&' 'sudo' 'do' 'time' 'strace' 'man' 'xargs')
    
    recolor-cmd() {
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
