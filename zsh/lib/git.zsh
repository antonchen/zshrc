#!/bin/zsh
# File: git.zsh
# Version: 0.1
# Last Modified: 2018-05-29 14:41:53
# Author: Anton Chen
# Email: contact@antonchen.com
_check_git()
{
    command -v git >/dev/null 2>&1 || return 1
    git rev-parse --git-dir >/dev/null 2>&1 && return 0 || return 1
}

_git_repo_name()
{
    local GIT_DIR
    GIT_DIR=$(git rev-parse --git-dir 2> /dev/null)
    if [[ "$GIT_DIR" == ".git" ]]; then
        echo -n $(basename $(pwd))
    elif [[ -n $GIT_DIR ]]; then
        echo -n $(dirname $GIT_DIR | xargs basename)
    fi
}

_git_branch_name()
{
    local B_TEMP B T H
    B_TEMP=$(git symbolic-ref HEAD 2>/dev/null)
    B=${B_TEMP##refs/heads/}
    T=$(git describe --exact-match --tags $(git log -n1 --pretty='%h') 2>/dev/null)
    H=$(git rev-parse --short HEAD 2>/dev/null)

    if [[ -n $B ]]; then
        echo $B
    elif [[ -n $T ]]; then
        echo "tags/$T"
    elif [[ -n $H ]]; then
        echo $H
    fi
}
