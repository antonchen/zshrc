# File: .zshrc
# Author: Anton Chen
# Version: 0.1
# Email: contact@antonchen.com
# Last Modified: 2026-11-22 15:48:59

. "$HOME/.profile"

# ZSH Home
ZSH="$HOME/.zsh"

# Plugins
PLUGINS='sudo'

# History format, Support: mm/dd/yyyy,dd.mm.yyyy,yyyy-mm-dd
HIST_STAMPS="yyyy-mm-dd"

# Colors ls
DISABLE_LS_COLORS="false"

# Colors command
DISABLE_COMMAND_COLORS="false"

# Auto title
DISABLE_AUTO_TITLE="false"

# Loading
# {{{

# Zsh config directory
if [[ ! -d "$ZSH" ]]; then
    echo $ZSH
    echo -e "\nError: Zsh directory does not exist. \n"
fi

# Load config
if [[ -f $ZSH/main.zsh ]]; then
    source $ZSH/main.zsh
else
    echo -e "\nError: main.zsh does not exist. \n"
fi

# Load alias
if [[ -f $ZSH/alias.zsh ]]; then
    source $ZSH/alias.zsh
else
    echo -e "\nError: alias.zsh does not exist.\n"
fi

# Load plugins
if [[ -f $ZSH/plugins.zsh ]]; then
    source $ZSH/plugins.zsh
else
    echo -e "\nError: plugins.zsh does not exist. \n"
fi

# }}}

