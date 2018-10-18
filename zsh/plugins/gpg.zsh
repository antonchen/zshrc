#!/bin/zsh
# File: gpg.zsh
# Author: Anton Chen
# Version: 0.1
# Email: contact@antonchen.com
# Last Modified: 2018-10-18 13:44:17

__gpg_is_exists=0
if command -v gpg > /dev/null 2>&1; then
    __gpg_is_exists=1
fi

if [ $__gpg_is_exists -eq 1 ] && [[ "$(uname)" == "Darwin" ]]; then
    pgrep -q gpg-agent
    if [ $? -ne 0 ]; then
        gpgconf --launch gpg-agent &
    fi
    export SSH_AUTH_SOCK="$HOME/.gnupg/S.gpg-agent.ssh"
fi
