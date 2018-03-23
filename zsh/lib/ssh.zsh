#!/bin/zsh
# File: ssh.zsh
# Version: 0.1
# Last Modified: 2018-03-23 23:26:02
# Author: Anton Chen
# Email: contact@antonchen.com

newSSH()
{
    cat $HOME/.ssh/ssh-config/* >$HOME/.ssh/config
}

alias rmssh="rm -f $HOME/.ssh/session/*"
