#!/bin/bash
# Create Date: 2017-05-17 11:24:39
# Last Modified: 2018-03-05 13:40:23
HERE=$(cd -P -- $(dirname -- "$0") && pwd -P)
DownloadURL='https://github.com/antonchen/zshrc/archive/master.zip'

if command -v wget > /dev/null 2>&1; then
    wget --no-check-certificate -O zshrc.zip -c $DownloadURL
elif command -v curl > /dev/null 2>&1; then
    curl -L -e  '; auto' -o zshrc.zip $DownloadURL
else
    echo "[-] Download file failed, please install wget or curl command." >&2
fi

if [ -f zshrc.zip ]; then
    test -d zshrc-master && rm -rf zshrc-master
    if unzip zshrc.zip; then
        mv zshrc-master zshrc
        rm -f zshrc.zip
    else
        echo "[-] Unzip file failed, please install unzip command." >&2
        exit 2
    fi
else
    echo "[-] Download failed." >&2
    exit 2
fi

if [ -d $HOME/.zsh ]; then
    echo "[+] Backup $HOME/.zsh to $HOME/.zsh_bak" >&2
    mv $HOME/.zsh{,_bak}
fi
if [ -f $HOME/.zshrc ]; then
    echo "[+] Backup $HOME/.zshrc to $HOME/.zshrc_bak" >&2
    mv $HOME/.zshrc{,_bak}
fi

cp -r zshrc/zsh $HOME/.zsh
cp zshrc/zshrc $HOME/.zshrc
rm -rf zshrc
echo "[+] Install simple zsh successfully." >&2
