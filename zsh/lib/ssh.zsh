#!/bin/zsh
# File: ssh.zsh
# Description: 
# Version: 0.1
# Create Date: 2016-08-18 18:07
# Last Modified: 2016-08-19 15:09
# Author: Anton Chen
# Email: contact@antonchen.com

newSSH ()
{
    cat $HOME/.ssh/ssh-config/* >$HOME/.ssh/config
}

alias rmssh="rm -f $HOME/.ssh/session/*"
