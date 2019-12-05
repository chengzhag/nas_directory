# NAS 使用说明


## 基本信息

* IP: 192.168.1.119
* 硬盘：
    * 机械硬盘：
        * 参数：7200 转 4T *5
        * 阵列：RAID 5
        * 型号：
            * Seagate ST4000NM000A 4TB *3
            * TOSHIBA MG04ACA400E 4TB *2
    * 固态硬盘：
        * 型号：三星 860 EVO 1T *4
        * 阵列：RAID 5
        * 用途：配置 Qtier 自动分层存储，保证 home 文件夹和常用数据集的读写速度
* 网络：
    * NAS：
        * SPF+ 万兆网口 *2
        * GbE rj45 网口 *2
    * 交换机：
        * 威联通万兆 QSW-1208-8C：
            * 万兆 N-Base 10GbE rj45 *8
            * 万兆 SPF+ *12（8 个与 rj45 复合，只能用其一）
        * 华三千兆 LS-MS4024：
            * 万兆 SPF+ *2
            * 千兆 GbE rj45 网口 *24
            * 用户个人电脑到 NAS、显卡服务器的快速连接
    * 网卡：显卡服务器上均配置了威联通 5GbE USB 网卡 QNA-UC5G1T *1


## 访问

* 管理页面：
    * 用户组：
        * administrators: 可管理 NAS 设置、用户权限等
        * managers, members: 可在管理页面访问允许的应用（如 Download Station）
    * 网址：[公网](http://kc110lsc.myqnapcloud.com/)，[内网](http://192.168.1.119/)
* [应用工具](https://www.qnap.com/zh-cn/utilities/essentials)：快捷访问 NAS
    * Qfinder Pro: 帮助您透过局域网络与 QNAP NAS 建立联机.。使用Windows 版本的「Storage Plug & Connect」功能，更可将 NAS 当作联机的网络驱动器或是虚拟磁盘。
	* myQNAPcloud Connect: 专为 Windows 使用者设计。安装后，使用者便可安全快速地存取区网内的 QNAP NAS，并可于档案总管内以拖曳的方式轻松管理档案。
    * Qsync: 自动将档案同步至与 QNAP NAS相连的装置上。
* 挂载：通过 NFS、SMB 等文件共享协议可以将 NAS 的 home 和 Public 文件夹挂载到个人电脑
    * NFS: 面向 **Linux/Unix** 用户
        * [如何在Ubuntu 18.04上设置NFS挂载](https://www.howtoing.com/how-to-set-up-an-nfs-mount-on-ubuntu-18-04): 挂载和卸载
        * [文件服务器之一：NFS服务器](http://cn.linux.vbird.org/linux_server/0330nfs.php): 详解
        * **说明 1**：显卡服务器采用此方式挂载，**个人电脑**也可使用此挂载方式，由于 NFS 本身的服务并没有进行身份登入的识别（[文件服务器之一：NFS服务器](http://cn.linux.vbird.org/linux_server/0330nfs.php)），因此挂载目录的权限会跟随个人电脑上登陆的用户和用户组，所以要求先完成以下两种配置以解决读写权限问题，如下: 
          1. *配置 LDAP 认证*:
            1. 安装必要软件：
                ```
                sudo apt install nfs-common
                ```
            2. #TODO: 在 本地 Linux 上配置 LDAP 认证，软件配置GUI过程中的选项， 之后可以通过以下命令挂载。
            3. 挂载 Public 文件夹：
                ```
                mkdir /media/Public
                sudo mount 192.168.1.119:/Public /media/Public
                ```
            4. 挂载 home 文件夹：
                ```
                sudo mount 192.168.1.119:/homes/${USER} {指定挂载目标路径}
                ```
            5. 如需卸载：
                ```
                sudo umount /media/Public
                ```
          2. *本地新建用户和NAS用户配对*:
            1. 本地新建配对用户组（与NAS认证用户的gid一致）:
                ```
                sudo groupadd -g ${gid} ${groupname}
                ``` 
            2. 本地新建配对用户（与NAS认证用户的uid、gid一致）:
                ```
                sudo useradd -m -u ${uid} -g ${gid} ${username}
                ```
    * SMB：CIFS, **Windows** 文件共享协议
        * [通过smb协议将服务器上的目录挂载至本地目录](https://www.qiansw.com/through-the-smb-protocol-on-the-server-directory-to-mount-a-local-directory.html)
        * 说明：也可以通过 Qfinder Pro 挂载
    * **MAC** 文件共享协议
        * 系统自带Finder中`前往 -> 连接服务器` 挂载到`192.168.1.119:/Public`或者`192.168.1.119:/home/${USER}` 默认使用的是和Windows相同`samba`文件共享协议，也可以再设置为`afp`等
        * 也可用[Qfinder Pro](https://www.qnap.com/zh-cn/how-to/tutorial/article/%E5%B0%86%E5%85%B1%E4%BA%AB%E6%96%87%E4%BB%B6%E5%A4%B9%E6%8C%82%E8%BD%BD%E5%88%B0-mac-%E8%AE%A1%E7%AE%97%E6%9C%BA/)软件辅助挂载
        * **注**: mac挂载可能第一次会遇到输入正确的用户名密码后无法连接，需要到管理员处重置一下密码即可。


## 网络

* 交换机 #TODO
* 路由器 #TODO


## 管理员

* [NAS 管理员说明](README_admin.md)
* [managers 管理员说明](README_managers.md)
