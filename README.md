# NAS 入门指南

NAS 实现了集中的网络存储，团队的所有数据集、用户文件都存储在 NAS 上，显卡服务器和个人电脑都可以高速地访问。

以下用 NAS:/ 表示 NAS 的根目录，GPU:/ 表示各显卡服务器的根目录。


## 变更

* 20200703: 修复了显卡服务器 manager 用户和 NAS 的 manager 用户冲突的问题，用 public 用户替代了 NAS 上的 manager 用户，将 NAS:/Public 下文件的所有者改为 public
* 20200703: 修复了显卡服务器上的 LDAP 配置
    * 之前通过 passwd 命令修改密码后发现 SMB 挂载登录失败或 NAS 管理页面可以登录但无法修改密码的，可以在显卡服务器上先用 passwd 临时改一下密码，再在 NAS 管理页面将密码改为想要的密码，就可以正常登录了
    * 今后密码仅能在 [NAS 管理页面](https://192.168.1.119:5001/cgi-bin/) 更改，不能在显卡服务器上通过 passwd 命令更改，否则会导致 SMB 挂载认证出错
* 20200511：添加了[外网访问的说明](documents/nas/README.md#外网访问)，可以通过 VPN 从外网访问 NAS 和 GPU 了
* 20200501：修复了用户无法通过图形界面登陆服务器的问题，老用户可按[服务器使用说明](documents/server/README.md)重新拷贝 .profile 文件来修复


## 说明

* [NAS 使用说明](documents/nas/README.md)：NAS 基本信息，如何访问 NAS，如何提升网速
* [服务器使用说明](documents/server/README.md)：如何初始化账号
* [EOS R 相机使用说明](documents/eos_r/README.md)


## 目录结构

NAS 私有文件夹 NAS:/homes/{user_name}，称为各用户的 home 文件夹：
* 存放个人的代码、数据集、软件等
* 只有 members 用户组的成员拥有，仅拥有者有读写权限
* members 和 managers 用户组的成员对 NAS:/homes 目录和他人的 home 文件夹有只读权限
* NAS:/homes 挂载到 GPU:/home 路径下，各用户可以将 anaconda 等软件安装于 home，使其在各显卡服务器间共享
* 各用户的存储空间有配额，可通过贡献或使用共享数据集避免个人配额的占用

NAS 共享文件夹 NAS:/Public，对 members 只读，存储说明文件和公共数据集：
* datasets: 公共数据集，通常是网上发布的，成熟的数据集，维护一个列表方便共享
    * {dataset_name}: 
        * 以完整原始目录结构（作者发布时的目录结构）保存在 {dataset_name} 文件夹下，每个数据集一个文件夹，目录结构不应有空格
        * 如果数据集下载为压缩包，需要解压至对应文件夹
        * 使用时链接到需要使用的目录下
    * README.md: 存放数据集的上传者、链接、分类、hash、大小等信息
    * 说明：任何人都可以只读地使用公共数据集，也可以贡献自己下载的数据集，以节省自己家目录的配额
* documents: 存放团队器材、服务器资料和文档
* README.md: 解释目录结构、新手入门


## 管理

用户组：administrators, managers, members，每人拥有一个账户，可能属于 members 用户组或同时属于 members, managers 用户组
* administrators: NAS 管理员（[NAS 管理员说明](documents/nas/README_admin.md)），为 NAS 本地用户
* managers: Public、github 仓库管理员（[managers 管理员说明](documents/nas/README_managers.md)）
* members: 普通用户
    * 允许：
        * 访问部分 NAS 应用，如 Download Station（[NAS 使用说明-访问-管理页面](documents/nas/README.md/#访问)）
        * 以只读权限访问 NAS:/Public 文件夹
        * 将 NAS 文件夹挂载到个人电脑（[NAS 使用说明-访问-挂载](documents/nas/README.md/#访问)）
    * 负责：向 github 仓库发起 pull request，贡献公共数据集和说明（[贡献](#贡献)）
    * 权限：
        * 对个人文件夹 NAS:/homes/{user_name} 的读写权限，但有容量限制
        * 显卡服务器上所有命令的 sudo 权限（暂定）

用户：在 NAS 和各显卡服务器上是通用的，administrators 用户组之外的用户密码会在各服务器之间同步，{user_name} 按以下规则命名
* members, managers: 姓名拼音命名，如 chencai, zhengzinan, zhangcheng
* administrators: 在 members 命名规则上添加 _admin 后缀。包括默认的 admin 用户（拥有最高权限）以及其他 NAS 管理员用户。

认证：
* administrators 为 NAS 本地用户组，只能在 NAS 上登陆
* managers, members 为集中认证用户组，可以在 NAS 和 显卡服务器上登陆


## 贡献

工具：贡献流程需要用到的工具
* [github](https://github.com/): 在 github 上注册账号，并了解其仓库、绑定客户端、issue 等基本功能
    * [Github入门与实践](https://www.jianshu.com/p/38611735b15e)
    * [GitHub 入门教程](https://www.cnblogs.com/xueweihan/p/7217846.html)
* [git](https://git-scm.com/): 安装 git 并了解克隆、提交、pull request 等 git 的基本操作
    * [猴子都能懂的GIT入门](https://backlog.com/git-tutorial/cn/)
    * [Git教程](https://www.liaoxuefeng.com/wiki/896043488029600)
* [gitkraken](https://www.gitkraken.com/): 一个 git 客户端，可以通过 GUI 实现克隆、提交等操作（也可使用其他 GUI 或命令行客户端）
    * [Learning Git with GitKraken](https://support.gitkraken.com/start-here/guide/)
    * [Support Home](https://support.gitkraken.com/)

公共数据集：将数据集提交到 NAS:/datasets 可以节省 home 文件夹的配额，方便团队使用
* 公共数据集保存在 NAS:/datasets
* 要求为网上发布的公开数据集
* 如何提交数据集请参考[公共数据集](datasets/README.md)

建议和补充：鼓励大家对本文档的错误进行修正，或进行补充说明
* 对 README 和 NAS:/Public/documents 等说明文件有修改建议和补充的：
    1. 将 [nas_directory](https://github.com/pidan1231239/nas_directory) 仓库克隆到个人电脑，进行修改和补充
    1. 完善 commit 信息并提交 commit
    1. 向原仓库发起 pull request，交由 managers 进行 merge
* 注意：pdf 等文件请勿提交到 commit 中，因为文件可能较大且无法追踪更改，应将此类文件暂存到个人 home 文件夹文件夹，并在 pull request 中说明此类文件的增改（说明将新增文件移动到 NAS:/Public 下的哪个文件或覆盖哪个文件）
