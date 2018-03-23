# File: sudo.zsh
# Author: Anton Chen
# Version: 0.1
# Email: contact@antonchen.com
# Last Modified: 2018-03-23 23:19:00

# 在命令前插入 sudo
sudo-command-line()
{
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    else
        LBUFFER="sudo $LBUFFER"
    fi
}
zle -N sudo-command-line
# 定义快捷键为： [Esc] [Esc]
bindkey "\e\e" sudo-command-line
