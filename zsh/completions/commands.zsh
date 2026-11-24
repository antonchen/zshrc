# kill 命令补全
compdef pkill=killall
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes' command 'ps -ef'

# 补全 ping
zstyle ':completion:*:ping:*' hosts 114.114.114.114 www.baidu.com

# SSH 主机补全
if [[ -f ~/.ssh/config ]]; then
    _ssh_config_hosts=$(grep 'Host ' ~/.ssh/config|grep -Ev '\*'|awk 'BEGIN{ORS=" "}{print $2}')
fi
_hosts=($(grep -Ev '^#|^$|localhost|broadcasthost' /etc/hosts|awk '{print $2}')
$(echo $_ssh_config_hosts))
if [[ -d ~/.ssh/session ]]; then
    for _ssh_session in $(ls ~/.ssh/session); do
        _hosts=($_hosts $(echo $_ssh_session|sed 's/\-[0-9]*\-[a-zA-Z]*$//g'))
    done
fi
zstyle ':completion:*' hosts $_hosts
zstyle ':completion:*' users $USER root

