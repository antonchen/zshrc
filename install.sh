#!/bin/bash
# Create Date: 2017-05-17 11:24:39
# Last Modified: 2018-10-18 18:13:14
DownloadURL='https://github.com/antonchen/zshrc/archive/master.tar.gz'

cd /tmp
if command -v wget > /dev/null 2>&1; then
    wget --no-check-certificate -O zshrc.tar.gz -c $DownloadURL
elif command -v curl > /dev/null 2>&1; then
    curl -k -L -e  '; auto' -o zshrc.tar.gz $DownloadURL
else
    echo "[-] Download file failed, please install wget or curl command." >&2
fi

if [ -f zshrc.tar.gz ]; then
    test -d zshrc-master && rm -rf zshrc-master
    echo "[+] Extracting files..." >&2
    if tar xf zshrc.tar.gz; then
        mv zshrc-master zshrc
        rm -f zshrc.tar.gz
    else
        echo "[-] Extract file failed." >&2
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
echo "[+] Install zshrc successfully." >&2
