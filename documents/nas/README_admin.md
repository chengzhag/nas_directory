# NAS 管理员说明


## 账号
admin 账号拥有最高权限，与显卡服务器的 root、admin 账号共用密码。


## 职责

* 配置 NAS
* 权限管理：文件权限、共享文件夹挂载权限等
* 增删用户


## 了解系统

* 详细系统清单: archives/NAS 清单.pdf
* NAS 调研报告: archives/NAS 调研.pdf


## 管理

* [NAS 使用说明](README.md)：了解基础的管理页面和应用工具
* 挂载服务端设置：
    * NFS: 面向linux/unix用户
        * [透过Linux NFS 储存服务，使用QNAP 企业级储存设备](https://www.qnap.com/zh-hk/how-to/tutorial/article/透過-linux-nfs-儲存服務使用-qnap-企業級儲存設備/)
        * [文件服务器之一：NFS服务器](http://cn.linux.vbird.org/linux_server/0330nfs.php)
    * SMB: CIFS, Windows文件共享协议
        * [如何在QTS 4.2 中使用SMB 3.0](https://www.qnap.com/zh-tw/how-to/tutorial/article/如何在-qts-4-2-中使用-smb-3-0/)
    * MAC 文件共享协议 #TODO
    * 对比：
        * [到底使用 nfs 还是 smb？ 说一下遇到的几个问题](https://www.v2ex.com/t/538664)
        * [Network share: Performance differences between NFS & SMB](https://ferhatakgun.com/network-share-performance-differences-between-nfs-smb/)


## 用户管理

* QNAP 本地用户管理：[文档](https://docs.qnap.com/nas/4.2/Home/sc/index.html?users.htm)
* LDAP:
    * 基础：[LDAP概念和原理介绍](https://www.cnblogs.com/wilburxu/p/9174353.html)
    * 客户端：[配置Ubuntu使用ldap认证](https://www.iteye.com/blog/wuyaweiwude-1889452)
    * 权限：[使用 PAM 集成 OpenLDAP 实现 Linux 统一管理系统用户](https://www.ibm.com/developerworks/cn/linux/1406_liulz_pamopenldap/index.html)，“虽然用户可以在 LDAP 上维护，但是用户的权限信息还是维护在各自的应用系统上”
	* 在 NAS 上配置自带的 LDAP 服务器：[如何使用 QNAP NAS 的 LDAP 伺服器完成用戶管理?](https://www.qnap.com/zh-hk/how-to/tutorial/article/如何使用-qnap-nas-的-ldap-伺服器完成用戶管理/)
	* 在客户端连接 LDAP 服务器：[connecting a linux client to a QNAP's LDAP server](https://laurentperrinet.github.io/sciblog/posts/2012-09-04-connecting-a-linux-client-to-a-QNAPs-LDAP-server.html):
		* 设置 IP 时用前缀 ldap://，在 NAS 设置-应用服务-LDAP 服务器里可以看到 Root DN 等设置
		* NAS 自带的 LDAP 服务器只有基础用户增删、密码设置功能，无法设置默认 shell 等参数
	* 要想实现更丰富的集中认证、用户管理功能，需要使用其他的 LDAP 服务：
        * 搭建 LDAP 服务器#TODO
		* [Connecting a QNAP NAS to an LDAP Directory](https://www.qnap.com/en/how-to/tutorial/article/connecting-a-qnap-nas-to-an-ldap-directory/)：在 NAS 上连接已有的 LDAP 服务器
* [QNAP NAS 进阶文件夹权限管理设定](https://www.qnap.com/zh-cn/how-to/tutorial/article/qnap-nas-%E8%BF%9B%E9%98%B6%E6%96%87%E4%BB%B6%E5%A4%B9%E6%9D%83%E9%99%90%E7%AE%A1%E7%90%86%E8%AE%BE%E5%AE%9A/)：启动高级文件权限可以为子文件夹分配权限，但考虑已经分配了多个共享文件夹，且有明确的权限规划，因此无需开启


## 网络

TODO: * 路由器
TODO: * 交换机


## 全新安装

[QNAP 线上安装](https://start.qnap.com/cn/?QfinderPro=1)
