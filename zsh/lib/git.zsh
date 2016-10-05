#!/bin/zsh
# File: git.zsh
# Description: 
# Version: 0.1
# Create Date: 2016-08-13 16:47
# Last Modified: 2016-08-14 21:50
# Author: Anton Chen
# Email: contact@antonchen.com
_check_git ()
{
    which git >/dev/null 2>&1 || return 1
    git rev-parse --git-dir >/dev/null 2>&1 && return 0 || return 1
}

_git_repo_name ()
{
  gitDir=$(git rev-parse --git-dir 2> /dev/null)
  if [[ "X$gitDir" == "X.git" ]]; then
    echo -n `basename $(pwd)`
  elif [[ "X$gitDir" != "X" ]]; then
    echo -n `dirname $gitDir | xargs basename`
  fi
}

_git_branch_name ()
{
    git name-rev --name-only --no-undefined --always HEAD 2>/dev/null
}
