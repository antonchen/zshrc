#!/bin/zsh
# File: anton.zsh-theme
# Version: 0.1
# Last Modified: 2018-03-23 23:26:45
# Author: Anton Chen
# Email: contact@antonchen.com
# 删除样式
FINISH="%{$reset_color%}"

# 定义颜色
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
    eval _$color='%{$fg_bold[${(L)color}]%}'
    eval $color='%{$fg[${(L)color}]%}'
    (( count = $count + 1 ))
done

# 提示符，双引号会导致变量解析，提示符就不会变
setopt prompt_subst

# User if root
if [[ $UID -eq 0 ]]; then
    NCOLOR="$_RED"
else
    NCOLOR="$_BLUE"
fi

# Git Status
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '✚'
zstyle ':vcs_info:*' unstagedstr '●'
zstyle ':vcs_info:*' formats ' %u%c'
zstyle ':vcs_info:*' actionformats ' %u%c'

prompt_git()
{
    _check_git
    if [[ $? -ne 0 ]]; then
        return
    fi

    vcs_info
    if [[ "Z${vcs_info_msg_0_}" == "Z " ]]; then
        echo -n "%{$fg_bold[green]%}$(_git_repo_name) [ $(_git_branch_name) ]$FINISH"
    else
        echo -n "%{$fg_bold[yellow]%}$(_git_repo_name) [ $(_git_branch_name)${vcs_info_msg_0_} ]$FINISH"
    fi
}

RPROMPT=''
PROMPT='$MAGENTA%m$FINISH $_CYAN%~ $FINISH
$NCOLOR%n$FINISH %(?.$GREEN.$RED)% ➜  $FINISH'

# 利用 zsh 内置调用函数异步加载RPROMPT
ASYNC_PROC=0
precmd()
{
    __async()
    {
        # 保存 RPROMPT 到临时文件
        printf "%s" "$(prompt_git)" > "${HOME}/.zsh_tmp_prompt"
        # signal parent
        kill -s USR1 $$
    }

    # 如有必要杀子进程
    if [[ "${ASYNC_PROC}" != 0 ]]; then
        kill -s HUP $ASYNC_PROC >/dev/null 2>&1 || :
    fi

    # 后台运行
    __async &!
    ASYNC_PROC=$!
}

TRAPUSR1()
{
    # 读取 RPROMPT
    RPROMPT="$(cat ${HOME}/.zsh_tmp_prompt)"
    # 重置 ASYNC_PROC
    ASYNC_PROC=0
    # 载入 RPROMPT
    zle && zle reset-prompt
}
