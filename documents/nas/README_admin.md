# NAS 管理员说明


## 账号
admin 账号拥有最高权限，与显卡服务器的 root、admin 账号共用密码。


## 职责

* 配置 NAS
* 权限管理：文件权限、共享文件夹挂载权限等
* 增删用户，添加服务器


## 了解系统

* 详细系统清单: archives/NAS 清单.pdf
* NAS 调研报告: archives/NAS 调研.pdf


## 管理

* 新增用户：
    1. 在 LDAP 用户管理页面新增用户：控制台 - 应用服务 - LDAP 服务器 - 用户 - 创建 - 创建用户
    1. 在 QVPN 应用中添加用户 VPN 连接权限：VPN 服务器 - 权限设置 - 添加 VPN 用户 - 下拉选择“域用户” - 勾选新用户的 OpenVPN - 保存
    1. 提醒用户按[服务器使用说明](/documents/server/README.md)初始化用户
* 删除用户：
    1. 在 LDAP 用户管理页面删除用户：控制台 - 应用服务 - LDAP 服务器 - 用户 - 选中需要删除的用户 - 删除
    1. 删除用户 home 文件夹：打开文件管理器 - 定位到 homes 文件夹 - 右键单击用户文件夹删除
* 新增显卡服务器：
    1. 打开管理页面 - 控制台 - 权限 - 共享文件夹 - NFS
    1. 根据各显卡服务器的主机名或 IP 添加访问权限，Squash 设置为 NO_ROOT_SQUASH，Public 和 homes 均设为读写


## 补充资料

* [NAS 使用说明](README.md)：了解基础的管理页面和应用工具
* 挂载服务端设置：
    * NFS: 显卡服务器采用此方式挂载（目前 NFS 挂载存在配置麻烦、[无法使用 git clone 的问题](../server/README.md#问题)）
        * [透过Linux NFS 储存服务，使用QNAP 企业级储存设备](https://www.qnap.com/zh-hk/how-to/tutorial/article/透過-linux-nfs-儲存服務使用-qnap-企業級儲存設備/)
        * [文件服务器之一：NFS服务器](http://cn.linux.vbird.org/linux_server/0330nfs.php)
    * SMB: CIFS, Windows文件共享协议
        * [如何在QTS 4.2 中使用SMB 3.0](https://www.qnap.com/zh-tw/how-to/tutorial/article/如何在-qts-4-2-中使用-smb-3-0/)
    * MAC 文件共享协议 
        * 系统自带Finder中`前往 -> 连接服务器` 挂载到`192.168.1.119:Public`或者`192.168.1.119:/home/{$USER}` 默认使用的是和Windows相同`samba`文件共享协议，也可以再设置为`afp`等
        * 也可用[Qfinder Pro](https://www.qnap.com/zh-cn/how-to/tutorial/article/%E5%B0%86%E5%85%B1%E4%BA%AB%E6%96%87%E4%BB%B6%E5%A4%B9%E6%8C%82%E8%BD%BD%E5%88%B0-mac-%E8%AE%A1%E7%AE%97%E6%9C%BA/)软件辅助挂载
        * **注**: mac挂载可能第一次会遇到输入正确的用户名密码后无法连接，需要到管理员处重置一下密码即可。
    * 对比：
        * [到底使用 nfs 还是 smb？ 说一下遇到的几个问题](https://www.v2ex.com/t/538664)
        * [Network share: Performance differences between NFS & SMB](https://ferhatakgun.com/network-share-performance-differences-between-nfs-smb/)
* QNAP 本地用户管理：[文档](https://docs.qnap.com/nas/4.2/Home/sc/index.html?users.htm)
* LDAP: 用于管理用户和集中认证登陆
    * 基础：[LDAP概念和原理介绍](https://www.cnblogs.com/wilburxu/p/9174353.html)
    * 客户端：[配置Ubuntu使用ldap认证](https://www.iteye.com/blog/wuyaweiwude-1889452)
    * 权限：[使用 PAM 集成 OpenLDAP 实现 Linux 统一管理系统用户](https://www.ibm.com/developerworks/cn/linux/1406_liulz_pamopenldap/index.html)，“虽然用户可以在 LDAP 上维护，但是用户的权限信息还是维护在各自的应用系统上”
    * 在 NAS 上配置自带的 LDAP 服务器：[如何使用 QNAP NAS 的 LDAP 伺服器完成用戶管理?](https://www.qnap.com/zh-hk/how-to/tutorial/article/如何使用-qnap-nas-的-ldap-伺服器完成用戶管理/)
    * 在客户端连接 LDAP 服务器：[connecting a linux client to a QNAP's LDAP server](https://laurentperrinet.github.io/sciblog/posts/2012-09-04-connecting-a-linux-client-to-a-QNAPs-LDAP-server.html):
        * 设置 IP 时用前缀 ldap://，在 NAS 设置-应用服务-LDAP 服务器里可以看到 Root DN 等设置
        * NAS 自带的 LDAP 服务器只有基础用户增删、密码设置功能，无法设置默认 shell 等参数
* [QNAP NAS 进阶文件夹权限管理设定](https://www.qnap.com/zh-cn/how-to/tutorial/article/qnap-nas-%E8%BF%9B%E9%98%B6%E6%96%87%E4%BB%B6%E5%A4%B9%E6%9D%83%E9%99%90%E7%AE%A1%E7%90%86%E8%AE%BE%E5%AE%9A/)：启动高级文件权限可以为子文件夹分配权限，但考虑已经分配了多个共享文件夹，且有明确的权限规划，因此无需开启


## 全新安装

[QNAP 线上安装](https://start.qnap.com/cn/?QfinderPro=1)

设置：
* 系统：
    * 常规设置：
        * 服务器名称：kc110lsc
        * 时间服务器：cn.ntp.org.cn
    * 存储与快照总管：
        * 配置好 Qtier
        * 概述 - 快照：设置每天保存一次快照，保存 5 天
        * 存储空间 - 磁盘 - 磁盘运行状况 - 设置：每天进行快速测试，对 HDD 每周进行完整测试
    * 硬件 - 警告音：取消勾选“系统程序”
    * 外接设备 - UPS：勾选“当电源失效时，10 分钟之后将进入自动保护模式”
    * 通知中心：配置好 admin 账户的通知
* 网络 & 文件服务：
    * 网络与虚拟交换机：配置好万兆网口的链路聚合，Balance-alb
    * Win/Max/NFS：开启三种网络文件协议
* 应用服务：
    * LDAP 服务器：启用
        * 完整的域名：kc110lsc.local
        * 应用并选择微软挂载采用 LDAP 认证
        * 启用此NAS作为LDAP服务的客户端
        * 群组：managers, members
        * 用户：新建各团队成员的账户，设置初始密码和邮箱
        * 备份 / 恢复：设置备份数据库，备份到 Public/
* 权限：
    * 域安全认证：选择 LDAP 认证 - 本机 NAS 上的 LDAP 服务器
    * 用户：确保“用户家目录”为启用
    * 用户组：设置 managers, members 用户组的文件夹访问权限
    * 共享文件夹：确保 Public 和 homes 共享文件夹各权限类别的权限
        * Public: managers 用户组权限设为读写，members 用户组权限设为只读
        * homes: managers 和 members 用户组权限均设为只读，这样可以避免用户间无意删除数据，且各自的 home 目录对各用户还是可读写的
        * NFS：
            * 根据各显卡服务器的主机名或 IP 添加访问权限，Squash 设置为 NO_ROOT_SQUASH，Public 和 homes 均设为读写
            * 添加“*”主机以设置其他客户端的访问权限，Squash 设置为 ROOT_SQUASH，Public 设为只读，homes 设为读写
    * 磁盘限额：设置每个用户的磁盘配额
* APP Center：
    * 安装 Download Station



