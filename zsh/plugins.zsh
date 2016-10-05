#!/bin/zsh
# File: plugins.zsh
# Description: 
# Version: 0.1
# Create Date: 2016-08-07 16:04
# Last Modified: 2016-09-23 13:59
# Author: Anton Chen
# Email: contact@antonchen.com

for plugin in `echo $PLUGINS|xargs`; do
    if [[ -f $ZSH/plugins/${plugin}.zsh ]]; then
        source $ZSH/plugins/${plugin}.zsh
    else
        echo -e "\nError: $plugin plugins does not exist. \n"
    fi
done
