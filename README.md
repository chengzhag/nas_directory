# 目录结构

* /datasets: 公共数据集，通常是网上发布的，成熟的数据集，维护一个列表方便共享
    * {dataset_name}: 只读
        * 以完整原始目录结构（作者发布时的目录结构）保存在 {dataset_name} 文件夹下，每个数据集一个文件夹，目录结构不应有空格
        * 如果数据集下载为压缩包，需要解压至对应文件夹
        * 使用时通过挂载或链接到需要使用的目录下
    * README.md（或某种表格文件？）: 存放数据集的上传者、链接、分类、hash、大小等信息
* /download: 下载的文件，如数据集压缩包，定期清理
* /homes: 存放个人的代码、数据集等
	* {user_name}: 用全名命名，姓、名用下划线隔开，如 chen_cai, zheng_zinan, zhang_cheng
        * projects/{project_name}
        * datasets/{dataset_name}: 仅存放私有数据集，如自己采集的数据集。公共数据集（网上发布的）必须保存在 /public/datasets 文件夹。
    * template_user: 模板用户文件夹，包括完整目录结构，建立新用户的时候可直接复制
* /documents：存放团队器材、服务器资料和文档
    * nas: 存放 NAS 使用说明和规范
* /README.md: 解释目录结构、新手入门
