# File: main.zsh
# Author: Anton Chen
# Version: 0.1
# Email: contact@antonchen.com
# Last Modified: 2018-05-02 15:30:25

# Basic settings
# {{{

# 补全初始化和规则
source "$ZSH/completions/init.zsh"
source "$ZSH/completions/commands.zsh"

# Initializes
for config in "$ZSH"/lib/*.zsh; do
    source "$config"
done

# 允许在命令后添加注释
setopt interactive_comments      
# 禁用 no matches 提示
setopt no_nomatch
# 注销时不结束后台进程
setopt nohup
# 禁用粘贴高亮
zle_highlight+=(paste:none)

if [[ -z "$ZSH_THEME" ]]; then
    source $ZSH/themes/anton.zsh-theme
else
    source $ZSH/themes/$ZSH_THEME.zsh-theme
fi
# }}}

