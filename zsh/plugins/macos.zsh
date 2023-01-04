#!/bin/zsh
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

if command -v brew > /dev/null 2>&1; then
    # Brew mirrors
    export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
    export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
fi

if [[ -f /opt/local/bin/port ]]; then
    export PATH=/opt/local/bin:/opt/local/sbin:$PATH
fi

vncviewer()
{
  open vnc://$@
}

# Show/hide hidden files in the Finder
alias showfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
