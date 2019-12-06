# 公共数据集

NAS:/Public/datasets 文件夹用于存储公共数据集（网上发布的公开数据集），只读。将数据集提交到 NAS:/datasets 可以节省 home 文件夹的配额。

所有用户都可以通过以下方式提交自己下载的数据集：
1. 下载数据集到个人 home 文件夹
1. 将数据集解压到个人 home 文件夹任意位置，以数据集名称命名，命名应不包含空格，空格以 '_' 替代
1. 将 [nas_directory](https://github.com/pidan1231239/nas_directory) 仓库克隆到个人电脑，编辑 datasets/README.md，按格式添加数据集的信息
1. 完善 commit 信息（添加公共数据集 {dataset_name}）并 commit
1. 向原仓库发起 pull request（标题“添加公共数据集 {dataset_name}”），并在描述中补充数据集所在路径（如 homes/{user_name}/datasets/{dataset_name}）
1. 交由 managers（管理员请参考[公共数据集入库说明](README_managers.md)）进行 merge 并将数据集入库到 NAS:/Public/datasets

## TODO: 添加模板

