#!/bin/zsh
# File: alias.zsh
# Description: 
# Version: 0.1
# Create Date: 2016-09-23 13:49
# Last Modified: 2017-03-14 10:26
# Author: Anton Chen
# Email: contact@antonchen.com

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

alias unzip_gbk="unzip -O CP936"
alias rscp='rsync -P --rsh=ssh'
alias aria2c='aria2c -c -s 5'
alias fuck='proxychains4'
alias g='git'

# 路径别名
# 进入相应的路径时只要 cd ~xxx
# hash -d W="/data/working"

# }}}
