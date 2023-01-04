#!/bin/zsh
# File: completion.zsh
# Version: 0.1
# Last Modified: 2023-01-04 17:32:21
# Author: Anton Chen
# Email: contact@antonchen.com

# 自动补全缓存
# zstyle ':completion::complete:*' use-cache on
# zstyle ':completion::complete:*' cache-path .zcache
# zstyle ':completion:*:cd:*' ignore-parents parent pwd


#自动补全功能
setopt AUTO_LIST
setopt AUTO_MENU

# 扩展路径
# /v/c/p/p => /var/cache/pacman/pkg
setopt complete_in_word

# 补全时会直接选中菜单项
# setopt MENU_COMPLETE
if [[ -f ~/.ssh/config ]]; then
    _ssh_config_hosts=$(grep 'Host ' ~/.ssh/config|egrep -v '\*'|awk 'BEGIN{ORS=" "}{print $2}')
fi
_hosts=($(egrep -v '^#|^$|localhost|broadcasthost' /etc/hosts|awk '{print $2}')
$(echo $_ssh_config_hosts))
if [[ -d ~/.ssh/session ]]; then
    for _ssh_session in $(ls ~/.ssh/session); do
        _hosts=($_hosts $(echo $_ssh_session|sed 's/\-[0-9]*\-[a-zA-Z]*$//g'))
    done
fi
zstyle ':completion:*' hosts $_hosts
zstyle ':completion:*' users $USER root

# 修正大小写
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
# 错误校正      
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# cd ~ 补全顺序
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'

# 自动补全选项
zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*:*:default' force-list always
zstyle ':completion:*' select-prompt '%SSelect:  lines: %L  matches: %M  [%p]'

zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate

# 路径补全
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-shlashes 'yes'
zstyle ':completion::complete:*' '\\'

# 彩色补全菜单 
zmodload zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LSCOLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# kill 命令补全      
compdef pkill=kill
compdef pkill=killall
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes' command 'ps -ef'

# 补全类型提示分组 
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'
zstyle ':completion:*:corrections' format $'\e[01;32m -- %d (errors: %e) --\e[0m'
