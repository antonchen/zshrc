# File: python.zsh
# Author: Anton Chen
# Version: 0.1
# Email: contact@antonchen.com
# Last Modified: 2018-03-23 22:28:04

__pyenv_started=0

__pyenv_init()
{
    test $__pyenv_started = 0 && {
        if command -v pyenv > /dev/null 2>&1; then
            eval "$(command pyenv init -)"
        fi
        __pyenv_started=1
    }
}

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
