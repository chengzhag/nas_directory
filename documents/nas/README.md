# NAS 使用说明


## 基本信息

* IP: 192.168.1.119
* 硬盘：
    * 机械硬盘：7200 转 4T *5，RAID 5
        * Seagate ST4000NM000A 4TB *3
        * TOSHIBA MG04ACA400E 4TB *2
    * 固态硬盘：三星 860 EVO 1T *4，RAID 5，用于缓存
* 网络：
    * SPF+ 万兆网口 *2
    * 威联通万兆交换机：QSW-1208-8C，N-Base 10GbE rj45 *8，万兆 SPF+ *12（8 个与 rj45 复合，只能用其一）


## 访问

* 管理页面：
    * 用户组：
        * administrators: 管理员，可管理 NAS 设置、用户权限等
        * everyone: 普通用户，可在管理页面访问允许的应用（如 Download Station）
    * 网址：
        * [公网](http://kc110lsc.myqnapcloud.com/)
        * [内网](http://192.168.1.119/)
* [应用工具](https://www.qnap.com/zh-cn/utilities/essentials)：快捷访问 NAS
    * Qfinder Pro: 帮助您透过局域网络与 QNAP NAS 建立联机.。使用Windows 版本的「Storage Plug & Connect」功能，更可将 NAS 当作联机的网络驱动器或是虚拟磁盘。
	* myQNAPcloud Connect: 专为 Windows 使用者设计。安装后，使用者便可安全快速地存取区网内的 QNAP NAS，并可于档案总管内以拖曳的方式轻松管理档案。
* 挂载：通过 NFS、SMB 等文件共享协议可以将 NAS 通过局域网挂载到本地
    * NFS: 面向linux/unix用户
        * [如何在Ubuntu 18.04上设置NFS挂载](https://www.howtoing.com/how-to-set-up-an-nfs-mount-on-ubuntu-18-04): 挂载和卸载
        * [文件服务器之一：NFS服务器](http://cn.linux.vbird.org/linux_server/0330nfs.php): 详解
        * 说明 1：显卡服务器采用此方式挂载，统一将 NAS 的 Public 共享文件夹挂载到 /media/Pyblic 路径下。已有的显卡服务器已设置好挂载，没有的可以参考以下命令。
            ```
            mkdir /media/Public
            sudo mount 192.168.1.119:/Public /media/Public
            sudo umount /media/Public
            ```
        * 说明 2：由于 NFS 本身的服务并没有进行身份登入的识别（[文件服务器之一：NFS服务器](http://cn.linux.vbird.org/linux_server/0330nfs.php)），因此 NAS 设置了客户端 IP 白名单，如需要通过 linux 客户端挂载 NAS，请为客户端设置固定 IP 并联系管理员设置白名单。
    * SMB：CIFS, Windows 文件共享协议
        * [通过smb协议将服务器上的目录挂载至本地目录](https://www.qiansw.com/through-the-smb-protocol-on-the-server-directory-to-mount-a-local-directory.html)
        * 说明：也可以通过 Qfinder Pro 挂载
TODO:     * MAC 文件共享协议


## 网络

TODO: * 交换机
TODO: * 路由器


## 管理员

* [NAS 管理员说明](README_admin.md)
