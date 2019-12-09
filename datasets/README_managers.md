# 公共数据集入库说明

所有 managers 用户通过以下流程入库用户提交的的数据集：
1. 在 github 上分配到 issue 后，审查用户提交的 pull request 是否符合规范（README 中的小问题可以直接修改并 commit，问题较大可在 issue 中告知用户自行修改）
1. 根据用户在 issue 中提供的路径找到其家目录中的数据集 {dataset_name}（从用户的 issue 描述中得知），并拷贝到 NAS:/Public/datasets/{dataset_name} 文件夹（用 NAS 的管理页面拷贝获得最快速度）
1. 在显卡服务器上通过以下命令将 NAS:/Public/datasets/{dataset_name} 文件夹的 owner 改为 root.root（可以保证数据集只读，并从提交用户的个人配额计算中剔除该文件夹）
    ```
    sudo chown -R root.root {dataset_name}
    ```
1. 打开 NAS:/Public 的 git 仓库并拉取（Pull） github 的更新
1. 在 github 上 close issue
