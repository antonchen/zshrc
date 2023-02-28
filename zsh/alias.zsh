#!/bin/zsh
# File: alias.zsh
# Version: 0.1
# Last Modified: 2023-01-07 23:32:44
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

if command -v npm > /dev/null 2>&1; then
    alias cnpm="npm --registry=https://registry.npm.taobao.org --cache=$HOME/.npm/.cache/cnpm --disturl=https://npm.taobao.org/dist --userconfig=$HOME/.cnpmrc"
fi

# 路径别名
# 进入相应的路径时只要 cd ~xxx
# hash -d W="/data/working"

# }}}
