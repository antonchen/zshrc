# File: main.zsh
# Author: Anton Chen
# Version: 0.1
# Email: contact@antonchen.com
# Last Modified: 2018-03-23 23:59:43

# Basic settings
# {{{

# Load PATH
if [[ -f /etc/profile ]]; then
    emulate sh -c 'source /etc/profile'
fi

autoload -Uz compinit
_comp_files=(${ZDOTDIR:-$HOME}/.zcompdump(Nm-12))
if [[ -n $_comp_files ]]; then
    compinit -i -C
else
    compinit -i
fi
unset _comp_files

# Initializes
for config in $(ls $ZSH/lib/*.zsh); do
    source $config
done

# 允许在命令后添加注释
setopt INTERACTIVE_COMMENTS      
# Fix no matches
setopt no_nomatch
# 禁用粘贴高亮
zle_highlight+=(paste:none)

if [[ -z "$ZSH_THEME" ]]; then
    source $ZSH/themes/anton.zsh-theme
else
    source $ZSH/themes/$ZSH_THEME.zsh-theme
fi
# }}}

# 自定义补全
# {{{

# 补全 ping
zstyle ':completion:*:ping:*' hosts 114.114.114.114 www.baidu.com

# 空行(光标在行首)补全 "cd"
insert-cd() {
case $BUFFER in
    "" )                       # 空行填入 "cd "
        BUFFER="cd "
        zle end-of-line
        zle expand-or-complete
        ;;
    "cd --" )                  # "cd --" 替换为 "cd +"
        BUFFER="cd +"
        zle end-of-line
        zle expand-or-complete
        ;;
    "cd +-" )                  # "cd +-" 替换为 "cd -"
        BUFFER="cd -"
        zle end-of-line
        zle expand-or-complete
        ;;
    * )
        zle expand-or-complete
        ;;
esac
}
zle -N insert-cd
bindkey "\t" insert-cd
# }}}
