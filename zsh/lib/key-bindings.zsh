#!/bin/zsh
# File: key-bindings.zsh
# Version: 0.1
# Last Modified: 2026-11-05 11:25:38
# Author: Anton Chen
# Email: contact@antonchen.com

# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets

if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  zle-line-init()
  {
    echoti smkx
  }
  zle-line-finish()
  {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

# 以下字符视为一个单词
#WORDCHARS='*?_-[]~=&;!#$%^(){}<>'

# Emacs风格 快捷键绑定
bindkey -e

# 空行(光标在行首)补全 "cd"
insert-cd() {
case $BUFFER in
    "" )                       # 空行填入 "cd "
        BUFFER="cd "
        zle end-of-line
        zle expand-or-complete
        ;;
    "cd --" )                  # "cd --" 替换为 "cd +"
        BUFFER="cd +"
        zle end-of-line
        zle expand-or-complete
        ;;
    "cd +-" )                  # "cd +-" 替换为 "cd -"
        BUFFER="cd -"
        zle end-of-line
        zle expand-or-complete
        ;;
    * )
        zle expand-or-complete
        ;;
esac
}
zle -N insert-cd
bindkey "\t" insert-cd

# 设置 [DEL]键
bindkey "\e[3~" delete-char
# Esc + w 剪切整行命令
bindkey '\ew' kill-region
# Ctrl + u 从光标处剪切命令至行首
bindkey '^U' backward-kill-line
# Ctrl + y 粘贴
bindkey '^Y' yank
# M + backspace 删除一个参数
autoload -Uz select-word-style
select-word-style shell
#select-word-style bash
bindkey '\e\b' backward-kill-word

# 用 $EDITER 编辑当前命令
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# 禁用 Ctrl + s 终端流控
stty -ixon

# 历史记录
# {{{
# Ctrl + r 搜索历史记录
bindkey '^r' history-incremental-search-backward

# Start command + [Up] - 向上搜索历史记录
if [[ "${terminfo[kcuu1]}" != "" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search
  bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi

# Start command + [Down] - 向下搜索历史记录
if [[ "${terminfo[kcud1]}" != "" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search
  bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi
# }}}
