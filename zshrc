# File: .zshrc
# Author: Anton Chen
# Version: 0.1
# Email: contact@antonchen.com
# Last Modified: 2018-11-12 11:08:57

# ZSH Home
export ZSH="$HOME/.zsh"

# Editor
export EDITOR="vim"

# Plugins
export PLUGINS='sudo warp'

# History format, Support: mm/dd/yyyy,dd.mm.yyyy,yyyy-mm-dd
export HIST_STAMPS="yyyy-mm-dd"

# Colors ls
export DISABLE_LS_COLORS="false"

# Colors command
export DISABLE_COMMAND_COLORS="false"

# Auto title
export DISABLE_AUTO_TITLE="false"

# PATH
# {{{

if command -v go > /dev/null 2>&1; then
    export GOPATH="$HOME/Golang"
    test -d $GOPATH || mkdir -p $GOPATH
    export PATH="$GOPATH/bin:$PATH"
fi

# }}}

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
