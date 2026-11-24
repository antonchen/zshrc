# 自动补全缓存
# zstyle ':completion::complete:*' use-cache on
# zstyle ':completion::complete:*' cache-path .zcache
# zstyle ':completion:*:cd:*' ignore-parents parent pwd

fpath=($ZSH/completions $fpath)
autoload -Uz compinit
_comp_files=(${ZDOTDIR:-$HOME}/.zcompdump(Nm-12))
if [[ -n $_comp_files ]]; then
    compinit -i -C
else
    compinit -i
fi
unset _comp_files

# 自动补全
setopt AUTO_LIST
setopt AUTO_MENU

# 扩展路径
# /v/c/p/p => /var/cache/pacman/pkg
setopt complete_in_word

# 补全时会直接选中菜单项
# setopt MENU_COMPLETE

# 修正大小写
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
# 错误校正
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _prefix _correct _match _approximate

# cd ~ 补全顺序
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'

# 自动补全菜单
zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*:*:default' force-list always
zstyle ':completion:*' select-prompt '%SSelect:  lines: %L  matches: %M  [%p]'
zmodload zsh/complist

# 路径补全
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes'

# 补全类型提示分组
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'

