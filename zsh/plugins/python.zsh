#!/bin/zsh
# File: python.zsh
# Author: Anton Chen
# Version: 0.2
# Email: contact@antonchen.com
# Last Modified: 2018-10-18 13:38:28

__pyenv_is_exists=0
if command -v pyenv > /dev/null 2>&1; then
    __pyenv_is_exists=1
fi

__pyenv_started=0
__pyenv_init()
{
    test $__pyenv_started = 0 && {
        if [[ $__pyenv_is_exists -eq 1 ]]; then
            echo $PATH|grep -q '.pyenv/shims' && export PATH="${PATH%%$HOME/.pyenv/shims:*}${PATH##*$HOME/.pyenv/shims:}"
            eval "$(command pyenv init -)"
        fi
        __pyenv_started=1
    }
}

test $__pyenv_started = 0 && {
    if [[ $__pyenv_is_exists -eq 1 ]] && [[ -d $HOME/.pyenv/shims ]]; then
        export PATH="$HOME/.pyenv/shims:$PATH"
        pyenv()
        {
            __pyenv_init
            command pyenv "$@"
        }
    elif [[ $__pyenv_is_exists -eq 1 ]] && [[ ! -d $HOME/.pyenv/shims ]]; then
        pyenv()
        {
            __pyenv_init
            command pyenv "$@"
        }

        python()
        {
            __pyenv_init
            command python "$@"
        }

        pip()
        {
            __pyenv_init
            command pip "$@"
        }
    fi
}
