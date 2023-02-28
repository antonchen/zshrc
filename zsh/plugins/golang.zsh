#!/bin/zsh
# File: golang.zsh
# Author: Anton Chen
# Version: 0.1
# Email: contact@antonchen.com
# Last Modified: 2023-02-28 14:20:29

if command -v go > /dev/null 2>&1; then
    export GOPATH="$HOME/Golang"
    test -d $GOPATH || mkdir -p $GOPATH
    export PATH="$GOPATH/bin:$PATH"
    export GO111MODULE=on
    export GOPROXY=https://goproxy.cn
fi
