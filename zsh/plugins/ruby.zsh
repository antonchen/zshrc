# File: ruby.zsh
# Author: Anton Chen
# Version: 0.1
# Email: contact@antonchen.com
# Last Modified: 2018-03-23 23:24:38

__rbenv_started=0

__rbenv_init()
{
    test $__rbenv_started = 0 && {
        if command -v rbenv > /dev/null 2>&1; then
            eval "$(command rbenv init -)"
        fi
        __rbenv_started=1
    }
}

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
