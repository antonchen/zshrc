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
    local git_color=green git_changes=''
    if [[ "Z${vcs_info_msg_0_}" != "Z " ]]; then
        git_color=yellow
        git_changes=$vcs_info_msg_0_
    fi
    local git_status="$(_git_repo_name) [ $(_git_branch_name)$git_changes ]"
    if [[ "$TERM_PROGRAM" == WezTerm || -n "$KITTY_WINDOW_ID" ]]; then
        print -rn -- "$git_status"
    else
        print -rn -- "%{$fg_bold[$git_color]%}$git_status$FINISH"
    fi
}

RPROMPT=''
PROMPT='$MAGENTA%m$FINISH $_CYAN%~ $FINISH
$NCOLOR%n$FINISH %(?.$GREEN.$RED)% ➜  $FINISH'

# 异步更新 Git 状态：WezTerm/Kitty 标签栏，其他终端右提示符
ZSH_PROMPT_FILE=''
ASYNC_PROC=0
precmd()
{
    __async()
    {
        # 保存 Git 状态到临时文件
        printf "%s" "$(prompt_git)" > "$ZSH_PROMPT_FILE"
        # signal parent
        kill -s USR1 $$
    }

    # 如有必要杀子进程
    if [[ "${ASYNC_PROC}" != 0 ]]; then
        kill -s HUP $ASYNC_PROC >/dev/null 2>&1 || :
        wait "$ASYNC_PROC" 2>/dev/null
    fi
    [[ -n "$ZSH_PROMPT_FILE" ]] && rm -f -- "$ZSH_PROMPT_FILE"
    ZSH_PROMPT_FILE=$(mktemp "/tmp/zsh-prompt.${UID}.$$.XXXXXX") || return

    # 后台运行
    __async &!
    ASYNC_PROC=$!
}

TRAPUSR1()
{
    # 已取消或已处理的任务可能仍有信号待处理
    [[ -f "$ZSH_PROMPT_FILE" ]] || return 0
    local prompt_file=$ZSH_PROMPT_FILE
    ZSH_PROMPT_FILE=''
    ASYNC_PROC=0
    if [[ "$TERM_PROGRAM" == WezTerm || -n "$KITTY_WINDOW_ID" ]]; then
        # 将 Git 状态发送到当前终端窗格
        printf '\e]1337;SetUserVar=GitStatus=%s\a' "$(base64 < "$prompt_file" | tr -d '\n')"
    else
        # 读取右提示符并刷新显示
        RPROMPT="$(< "$prompt_file")"
        zle && zle reset-prompt
    fi
    rm -f -- "$prompt_file"
}

# 退出时结束提示符任务并删除临时文件
TRAPEXIT()
{
    if [[ "$ASYNC_PROC" != 0 ]]; then
        kill -s HUP "$ASYNC_PROC" >/dev/null 2>&1 || :
        wait "$ASYNC_PROC" 2>/dev/null
    fi
    [[ -n "$ZSH_PROMPT_FILE" ]] && rm -f -- "$ZSH_PROMPT_FILE"
}
