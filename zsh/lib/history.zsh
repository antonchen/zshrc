# !/bin/zsh
# File: history.zsh
# Description: 
# Version: 0.1
# Create Date: 2016-07-31 14:25
# Last Modified: 2016-08-14 22:09
# Author: Anton Chen
# Email: contact@antonchen.com

# 历史纪录文件
if [ -z "$HISTFILE" ]; then
    export HISTFILE="$HOME/.zsh_history"
fi

#if [ ! -f $HISTFILE ]; then
#    touch $HISTFILE
#fi

# 历史纪录数量
export HISTSIZE=10000
# 注销后保存历史纪录数量
export SAVEHIST=10000
# 以附加的方式写入历史纪录
setopt INC_APPEND_HISTORY
# 如果连续输入的命令相同，历史纪录中只保留一个
setopt HIST_IGNORE_DUPS      
# 优先清空相通历史记录
setopt HIST_EXPIRE_DUPS_FIRST
# 为历史纪录中的命令添加时间戳      
setopt EXTENDED_HISTORY      
# 启用 cd 命令的历史纪录，cd -[TAB]进入历史路径
setopt AUTO_PUSHD
# 相同的历史路径只保留一个
setopt PUSHD_IGNORE_DUPS
# 在命令前添加空格，不将此命令添加到纪录文件中
setopt HIST_IGNORE_SPACE
# 调用历史记录时不直接执行，而是加载可编辑
setopt HIST_VERIFY

# 查看历史记录
case $HIST_STAMPS in
  "mm/dd/yyyy") alias history='fc -fl 1' ;;
  "dd.mm.yyyy") alias history='fc -El 1' ;;
  "yyyy-mm-dd") alias history='fc -il 1' ;;
  *) alias history='fc -l 1' ;;
esac

hs ()
{
    history | grep $*
}

alias hsi='hs -i'
alias h='history'
alias hc="cat /dev/null > $HISTFILE"
