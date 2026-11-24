#!/bin/zsh
# File: alias.zsh
# Version: 0.1
# Last Modified: 2026-10-31 18:30:43
# Author: Anton Chen
# Email: contact@antonchen.com

# {{{

# 命令别名
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias grep='grep --color=auto'
alias l='ls -lah'
alias ll='ls -lh'
alias la='l'
alias lh='l'

alias unzip_gbk="unzip -O CP936"
alias rscp='rsync -P --rsh=ssh'
alias aria2c='aria2c -c -s 5'
alias g='git'
alias reload='exec zsh'

# 直接输入指定后缀文件名，使用指定命令打开
alias -s js='vim'
alias -s txt='vim'
alias -s gz='tar -xzvf'
alias -s tgz='tar -xzvf'
alias -s bz2='tar -xjvf'
alias -s zip='unzip'

if ! command -v dig > /dev/null 2>&1 && command -v drill > /dev/null 2>&1; then
    alias dig="drill"
fi

# 路径别名
# 进入相应的路径时只要 cd ~xxx
# hash -d W="/data/working"

# }}}
