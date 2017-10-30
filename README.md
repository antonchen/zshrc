# Zshrc
My zsh config.

## 使用

```
wget -c https://github.com/antonchen/zshrc/archive/master.zip
unzip master.zip && cd zshrc-master
cp -r zsh ~/.zsh
cp zshrc ~/.zshrc
```

## 异常

每次启动 zsh 时提示：

```
zsh compinit: insecure files, run compaudit for list.
Ignore insecure files and continue [y] or abort compinit [n]?
```
这是因为 zsh 默认开启了安全检查，zsh 引入了有风险的文件。  
有风险的文件：非当前用户且非 root 用户、组和其它用户对文件有写权限。

### 解决方案

#### 方法 1
1. 运行 `compaudit | xargs chown -R "$(whoami)"`
2. 运行 `compaudit | xargs chmod go-w`
3. 如未修复请尝试方法 2
#### 方法 2
1. 修改 [zsh/main.zsh#L16](https://github.com/antonchen/zshrc/blob/master/zsh/main.zsh#L16) `compinit` 为 `compinit -u` 让 zsh 不检查
