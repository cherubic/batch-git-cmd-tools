# batch-git-cmd-tools
根据JSON/YAML统一进行git的相关操作

## 使用

### 环境

以下两种环境均可运行本程序。

1. 环境安装有Docker
2. 环境安装有bash,GUN grep, yq

### 配置文件

配置文件如下
```yaml
# 新建分支配置
newbranch:
    # 名称
  - name: example
    # 仓库地址（ssh地址需要本地配置好对应的认证信息，也可直接配置https对应地址）
    repo: "git@github.com:cherubic/batch-git-cmd-tools.git"
    # 源分支
    branch: "master"
    # 新分支
    newbranch: "example"
```

#### Docker环境中如何运行
1. 添加对应yaml配置
2. 运行如下命令创建新分支
```bash
COMMIT_ID=$(git rev-parse --short=8 HEAD)
docker run \
--mount type=bind,source=<source-config-file-path>,target=<target-config-file-path> \
--mount type=bind,source=<source-ssh-file-path>,target=/root/.ssh/id_rsa \
--mount type=bind,source=<source-log-dircetory>,target=/tmp/
batch-git-tools:${COMMIT_ID} /batch-git-command.sh -cp <target-config-file-path> -o newbranch -e "docker"
```

#### 主机环境中如何运行
1. 添加对应yaml配置
2. 运行如下命令创建新分支
```bash
batch-git-command.sh -cp <target-config-file-path> -o newbranch -e "host"
```