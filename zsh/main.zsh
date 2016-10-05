# File: main.zsh
# Author: Anton Chen
# Version: 0.1
# Email: contact@antonchen.com
# Last Modified: 2016-10-05 19:51

# Basic settings
# {{{

autoload -U compinit
compinit

# Initializes
for config in `ls $ZSH/lib/*.zsh`; do
    source $config
done

# 禁用 core dumps
limit coredumpsize 0
# 允许在命令后添加注释
setopt INTERACTIVE_COMMENTS      

if [ -z "$ZSH_THEME"]; then
    source $ZSH/themes/anton.zsh-theme
else
    source $ZSH/themes/$ZSH_THEME.zsh-theme
fi
# }}}

# Alias
# {{{

# 命令别名
alias -g cp='cp -i'
alias -g mv='mv -i'
alias -g rm='rm -i'
alias -g grep='grep --color=auto'
alias -g l='ls -lah'
alias -g ll='ls -lh'
alias -g la='l'
alias -g lh='l'
alias -g bash='time bash'

# 路径别名
# 进入相应的路径时只要 cd ~xxx
# hash -d W="/data/working"

# }}}

# 自定义补全
# {{{

# 补全 ping
zstyle ':completion:*:ping:*' hosts 114.114.114.114 www.baidu.com

# 空行(光标在行首)补全 "cd"
insert-cd () {
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
