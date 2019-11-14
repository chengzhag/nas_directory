# NAS 管理员说明


## 职责

* 负责管理 NAS 设置、用户权限等
* 负责设置文件权限、共享文件夹挂载权限等
* 负责 merge github 仓库的 pull request，拥有对说明文件的读写权限，并将 github 仓库的更新拉取到本地
* 负责对各公共数据集文件夹进行权限修改
* 拥有对除他人用户文件夹和已入库公共数据集外所有文件的读写权限


## 了解系统

* 详细系统清单: archives/NAS 清单.pdf
* NAS 调研报告: archives/NAS 调研.pdf


## 管理

* 全新安装：[QNAP 线上安装](https://start.qnap.com/cn/?QfinderPro=1)
* 挂载服务端设置：
    * NFS: 面向linux/unix用户
        * [透过Linux NFS 储存服务，使用QNAP 企业级储存设备](https://www.qnap.com/zh-hk/how-to/tutorial/article/透過-linux-nfs-儲存服務使用-qnap-企業級儲存設備/)
        * [文件服务器之一：NFS服务器](http://cn.linux.vbird.org/linux_server/0330nfs.php)
    * SMB: CIFS, Windows文件共享协议
        * [如何在QTS 4.2 中使用SMB 3.0](https://www.qnap.com/zh-tw/how-to/tutorial/article/如何在-qts-4-2-中使用-smb-3-0/)
TODO:     * MAC 文件共享协议
    * 对比：
        * [到底使用 nfs 还是 smb？ 说一下遇到的几个问题](https://www.v2ex.com/t/538664)
        * [Network share: Performance differences between NFS & SMB](https://ferhatakgun.com/network-share-performance-differences-between-nfs-smb/)
* [NAS 使用说明](README.md)


## 网络

TODO: * 路由器
TODO: * 交换机


## github 仓库

TODO: merge 注意事项，不能将大文件 merge 到 github 仓库
