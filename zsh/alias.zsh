#!/bin/zsh
# File: alias.zsh
# Description: 
# Version: 0.1
# Create Date: 2016-09-23 13:49
# Last Modified: 2018-02-28 14:40:56
# Author: Anton Chen
# Email: contact@antonchen.com

# {{{

# 全局别名
alias -g grep='grep --color=auto'

# 命令别名
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias l='ls -lah'
alias ll='ls -lh'
alias la='l'
alias lh='l'

alias unzip_gbk="unzip -O CP936"
alias rscp='rsync -P --rsh=ssh'
alias aria2c='aria2c -c -s 5'
alias fuck='proxychains4'
alias g='git'

# 路径别名
# 进入相应的路径时只要 cd ~xxx
# hash -d W="/data/working"

# }}}
