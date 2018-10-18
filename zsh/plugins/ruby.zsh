#!/bin/zsh
# File: ruby.zsh
# Author: Anton Chen
# Version: 0.2
# Email: contact@antonchen.com
# Last Modified: 2018-10-18 13:38:35

__rbenv_is_exists=0
if command -v rbenv > /dev/null 2>&1; then
    __rbenv_is_exists=1
fi

__rbenv_started=0
__rbenv_init()
{
    test $__rbenv_started = 0 && {
        if [[ $__rbenv_is_exists -eq 1 ]]; then
            echo $PATH|grep -q "$HOME/.rbenv/shims" && export PATH="${PATH%%$HOME/.rbenv/shims:*}${PATH##*$HOME/.rbenv/shims:}"
            eval "$(command rbenv init -)"
        fi
        __rbenv_started=1
    }
}

test $__rbenv_started = 0 && {
    if [[ $__rbenv_is_exists -eq 1 ]] && [[ -d $HOME/.rbenv/shims ]]; then
        export PATH="$HOME/.rbenv/shims:$PATH"
        rbenv()
        {
            __rbenv_init
            command rbenv "$@"
        }
    elif [[ $__rbenv_is_exists -eq 1 ]] && [[ ! -d $HOME/.rbenv/shims ]]; then
        rbenv()
        {
            __rbenv_init
            command rbenv "$@"
        }

        ruby()
        {
            __rbenv_init
            command ruby "$@"
        }

        rake()
        {
            __rbenv_init
            command rake "$@"
        }

        bundle()
        {
            __rbenv_init
            command bundle "$@"
        }
    fi
}
