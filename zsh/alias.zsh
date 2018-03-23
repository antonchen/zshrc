#!/bin/zsh
# File: alias.zsh
# Version: 0.1
# Last Modified: 2018-03-23 23:32:52
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
alias fuck='proxychains4'
alias g='git'

# 路径别名
# 进入相应的路径时只要 cd ~xxx
# hash -d W="/data/working"

# }}}
