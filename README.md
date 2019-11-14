# NAS 入门指南


## 管理

用户组：每人拥有一个用户，分属两个用户组
* administrators: 管理员（[NAS 管理员说明](documents/nas/README_admin.md)）
* everyone: 普通用户
    * 可以在管理页面访问允许的应用，如 Download Station（[NAS 使用说明-访问-管理页面](documents/nas/README.md/#访问)）
    * 可以以只读的方式访问说明文件，如 README 和 /documents
    * 负责向 github 仓库发起 pull request，提交新增公共数据集的说明（[贡献](#贡献)）
    * 可以将 NAS 文件夹挂载到客户端（[NAS 使用说明-访问-挂载](documents/nas/README.md/#访问)）
    * 拥有对个人文件夹（/home）和除说明文件、已入库公共数据集外所有公共文件的读写权限


## 目录结构

NAS 唯一开放的共享文件夹为 Public，其目录结构如下：
* /datasets: 公共数据集，通常是网上发布的，成熟的数据集，维护一个列表方便共享
    * {dataset_name}: 
        * 以完整原始目录结构（作者发布时的目录结构）保存在 {dataset_name} 文件夹下，每个数据集一个文件夹，目录结构不应有空格
        * 如果数据集下载为压缩包，需要解压至对应文件夹
        * 使用时通过挂载或链接到需要使用的目录下
    * README.md: 存放数据集的上传者、链接、分类、hash、大小等信息
    * 说明：任何人都可以
* /temp: 下载的文件，如数据集压缩包、临时解压的数据集等，定期清理
* /home: 存放个人的代码、数据集等
	* {user_name}: 用全名命名，姓、名用下划线隔开，如 chen_cai, zheng_zinan, zhang_cheng
        * projects/{project_name}
        * datasets/{dataset_name}: 仅存放私有数据集，如自己采集的数据集。公共数据集（网上发布的）必须保存在 /public/datasets 文件夹。
    * template_user: 模板用户文件夹，包括完整目录结构，建立新用户的时候可直接复制
* /documents: 存放团队器材、服务器资料和文档
    * nas: 存放 [NAS 使用说明](documents/nas/README.md)和规范
* /README.md: 解释目录结构、新手入门


## 说明 documents

* [NAS 使用说明](documents/nas/README.md)
TODO: 服务器使用说明
TODO: [EOS R 相机使用说明](documents/eos_r/README.md)


## 贡献

公共数据集：
* /datasets 文件夹用于存储公共数据集，已入库的数据集为只读
* /temp 文件夹可用于存放未入库的数据集
* 管理员和普通用户均通过以下步骤申请公共数据集入库：
    1. 下载数据集到 /temp 文件夹
    1. 将数据集解压到以数据集名称命名的文件夹，命名中的空格以 '_' 替代
    1. 在 clone 的 [nas_directory](https://github.com/pidan1231239/nas_directory) 仓库中编辑 /datasets/README.md，按格式添加数据集的信息
    1. 完善 commit 信息并提交 commit
    1. 向原仓库发起 pull request，交由管理员进行 merge 并将数据集入库到 /datasets

建议和补充：
* 对 README 和 /documents 等说明文件有修改建议和补充的：
    1. 在 clone 的[nas_directory](https://github.com/pidan1231239/nas_directory) 仓库中编辑
    1. 完善 commit 信息并提交 commit
    1. 向原仓库发起 pull request，交由管理员进行 merge
* 注意：pdf 等文件请勿提交到 commit 中，因为文件可能较大且无法追踪更改

TODO：详细贡献数据集、贡献说明，github 使用说明，gui git 软件建议，pull request 发起说明


