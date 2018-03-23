#!/bin/zsh
# File: plugins.zsh
# Version: 0.1
# Last Modified: 2018-03-23 22:57:45
# Author: Anton Chen
# Email: contact@antonchen.com

for plugin in $(echo "$PLUGINS"); do
    if [[ -f $ZSH/plugins/${plugin}.zsh ]]; then
        source $ZSH/plugins/${plugin}.zsh
    else
        echo -e "\nError: $plugin plugins does not exist. \n"
    fi
done
