# Zshrc
My zsh config.

## 安装

```
curl -s -k https://raw.githubusercontent.com/antonchen/zshrc/master/install.sh | bash
```

## 异常

启动 zsh 时提示：

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
1. 修改 [zsh/main.zsh#L18&L20](https://github.com/antonchen/zshrc/blob/master/zsh/main.zsh#L18) `compinit -i` 后添加 `-u` 让 zsh 不检查
