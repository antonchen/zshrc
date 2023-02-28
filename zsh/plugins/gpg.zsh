#!/bin/zsh
# File: gpg.zsh
# Author: Anton Chen
# Version: 0.1
# Email: contact@antonchen.com
# Last Modified: 2022-12-23 20:09:07

__gpg_is_exists=0
if command -v gpg > /dev/null 2>&1; then
    __gpg_is_exists=1
fi

if [ $__gpg_is_exists -eq 1 ] && [[ "$(uname)" == "Darwin" ]]; then
    pgrep -q gpg-agent
    if [ $? -ne 0 ]; then
        nohup gpgconf --launch gpg-agent > /dev/null 2>&1 &!
    fi
    export GPG_TTY=$(tty)
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
fi
