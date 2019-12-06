# 公共数据集

NAS:/Public/datasets 文件夹用于存储公共数据集（网上发布的公开数据集），只读。将数据集提交到 NAS:/datasets 可以节省 home 文件夹的配额。

所有用户都可以通过以下方式提交自己下载的数据集：
1. 下载数据集到个人 home 文件夹
1. 将数据集解压到个人 home 文件夹任意位置，以数据集名称命名，命名应不包含空格，空格以 '_' 替代
1. 将 [nas_directory](https://github.com/pidan1231239/nas_directory) 仓库 fork 到自己的 github 并克隆到个人电脑，编辑 datasets/README.md，按格式添加数据集的信息
1. 完善 commit 信息（添加公共数据集 {dataset_name}）并 commit，然后 Push 到 fork 的 github 仓库
1. 向原仓库发起 pull request：
    - 标题：添加公共数据集 {dataset_name}
    - Brach: master
    - 描述：数据集所在路径（如 homes/{user_name}/datasets/{dataset_name}）
    - 标签（tag）：dataset
1. 交由 managers（管理员请参考[公共数据集入库说明](README_managers.md)）进行 merge 并将数据集入库到 NAS:/Public/datasets
1. managers 工作结束后，用户检查提交的数据集是否正确拷贝到 NAS:/Public/datasets，README 是否正确更新，如果一切顺利，便可删除自己家目录的对应数据集

## 模板：CIFAR-10
- 主页：[The CIFAR-10 dataset](https://www.cs.toronto.edu/~kriz/cifar.html)
- 关键词：图像分类，image classification
- 引用：[Learning Multiple Layers of Features from Tiny Images](https://www.cs.toronto.edu/~kriz/learning-features-2009-TR.pdf), Alex Krizhevsky, 2009.
- 相关链接：
    - [What is the class of this image ?](http://rodrigob.github.io/are_we_there_yet/build/classification_datasets_results.html): Rodrigo Benenson has been kind enough to collect results on CIFAR-10/100 and other datasets on his website
    - [TensorFlow学习笔记（十）： CIFAR-10](https://blog.csdn.net/zeuseign/article/details/72773342)
    - [CIFAR-10 dataset 的下载与使用](https://www.cnblogs.com/irran/p/cifar-10.html)
- 说明：The CIFAR-10 dataset consists of 60000 32x32 colour images in 10 classes, with 6000 images per class. There are 50000 training images and 10000 test images.
- 下载连接/数据集相对路径：
    - [CIFAR-10 python version](https://www.cs.toronto.edu/~kriz/cifar-10-python.tar.gz) -> cifar-10/cifar-10-batches-py
    - [CIFAR-10 Matlab version](https://www.cs.toronto.edu/~kriz/cifar.html) -> cifar-10/cifar-10-batches-mat
    - [CIFAR-10 binary version (suitable for C programs)](https://www.cs.toronto.edu/~kriz/cifar.html) -> cifar-10/cifar-10-batches-bin
