# File: .zshrc
# Author: Anton Chen
# Version: 0.1
# Email: contact@antonchen.com
# Last Modified: 2016-11-09 14:31

# Brew mirrors
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"

# ZSH Home
export ZSH="$HOME/.zsh"

# Editor
export EDITOR="vim"

# Plugins
export PLUGINS='sudo anton'

# History format, Support: mm/dd/yyyy,dd.mm.yyyy,yyyy-mm-dd
export HIST_STAMPS="yyyy-mm-dd"

# Colors ls
export DISABLE_LS_COLORS="false"

# Colors command
export DISABLE_COMMAND_COLORS="false"

# Auto title
export DISABLE_AUTO_TITLE="false"

# Loading
# {{{

# Zsh config directory
if [[ ! -d "$ZSH" ]]; then
    echo $ZSH
    echo -e "\nError: Zsh config directory does not exist. \n"
fi

# Load config
if [[ -f $ZSH/main.zsh ]]; then
    source $ZSH/main.zsh
else
    echo -e "\nError: Main config does not exist. \n"
fi

# Load plugins
if [[ -f $ZSH/plugins.zsh ]]; then
    source $ZSH/plugins.zsh
else
    echo -e "\nError: Plugins config does not exist. \n"
fi

# }}}
