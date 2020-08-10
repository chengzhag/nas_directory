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
    * 网址：[公网](https://kc110lsc.myqnapcloud.cn:5001/cgi-bin/)，[内网](https://192.168.1.119:5001/cgi-bin/)
    * 功能：
        * Download Station：可以挂机下载 BT、HTTP、HTTPS、FTP、FTPS 文件
        * File Station：文件管理器，删除、移动、复制、解压等操作在这里进行可以比挂载后在终端上进行速度更快
        * 更改密码：右上角的用户名-设置选项-修改密码（密码仅能在管理页面更改，不能在显卡服务器上通过 passwd 命令更改，否则会导致 SMB 挂载认证出错）
* [应用工具](https://www.qnap.com/zh-cn/utilities/essentials)：快捷访问 NAS
    * Qfinder Pro: 帮助您透过局域网络与 QNAP NAS 建立联机.。使用Windows 版本的「Storage Plug & Connect」功能，更可将 NAS 当作联机的网络驱动器或是虚拟磁盘。
	* myQNAPcloud Connect: 专为 Windows 使用者设计。安装后，使用者便可安全快速地存取区网内的 QNAP NAS，并可于档案总管内以拖曳的方式轻松管理档案。
    * Qsync: 自动将档案同步至与 QNAP NAS相连的装置上。
* 挂载：通过 SMB 文件共享协议可以将 NAS 的 home 和 Public 文件夹挂载到个人电脑
    * Windows：
        * [通过smb协议将服务器上的目录挂载至本地目录](https://www.qiansw.com/through-the-smb-protocol-on-the-server-directory-to-mount-a-local-directory.html)
        * 说明：也可以通过 Qfinder Pro 挂载
    * MAC：
        * 系统自带Finder中 `前往 -> 连接服务器` 挂载到 `192.168.1.119:/Public` 或者 `192.168.1.119:/home/${USER}` 默认使用的是和Windows相同文件共享协议，也可以再设置为 `afp` 等
        * 也可用[Qfinder Pro](https://www.qnap.com/zh-cn/how-to/tutorial/article/%E5%B0%86%E5%85%B1%E4%BA%AB%E6%96%87%E4%BB%B6%E5%A4%B9%E6%8C%82%E8%BD%BD%E5%88%B0-mac-%E8%AE%A1%E7%AE%97%E6%9C%BA/)软件辅助挂载
    * Linux：
        * UI 界面挂载：以 Ubuntu 18 为例，可以在文件管理器左侧菜单栏点击“Other Locations”从自动发现的网络主机列表中选择“kc110lsc”（或在“Connect to Server”后填入 NAS IP），输入用户名和密码后即可访问共享文件夹，右键所需文件夹“Mount”即可挂载
        * [将SMB/CIFS网络硬盘永久的挂载到Ubuntu上](https://www.jianshu.com/p/4ec8ad9b9820)
		* CIFS永久挂载补充说明：需要在指定passwd之后，再指定 gid=local username，uid=local username，否则会默认都属于root组，自己无法编辑挂载后的文件
    * **说明**: 20200703
        * 之前通过 passwd 命令修改密码后发现 SMB 挂载登录失败或 NAS 管理页面可以登录但无法修改密码的，可以在显卡服务器上先用 passwd 临时改一下密码，再在 NAS 管理页面将密码改为想要的密码，就可以正常登录了
        * 今后密码仅能在 [NAS 管理页面](https://192.168.1.119:5001/cgi-bin/) 更改，不能在显卡服务器上通过 passwd 命令更改，否则会导致 SMB 挂载认证出错
* 快照：
    * NAS 开启了每天快照，会自动在凌晨 1 点创建整盘快照，每个快照保存 5 天，可以从快照中恢复误删或误修改的文件
    * 所有用户均可通过共享文件夹（NAS:/Public，NAS:/homes）根目录下的 @Recently-Snapshot 文件夹访问快照，可通过管理页面 File Station 或挂载两种方式


## 网络

转移到千兆交换机：教研室的配套交换机（服务器旁的壁挂支架上，共四台）是百兆的，极大地限制了个人电脑到显卡服务器和 NAS 之间的传输速度，为此，团队配备了一台千兆交换机，由同学们自行连接（以下操作将临时断开个人电脑的网络连接）
1. 在自己的座位下查看网线插座上的编号
1. 在显卡服务器旁的壁挂交换机上找到相同编号的网线，并拔下你的网线
1. 依次松开捆绑了你的网线的绑扎带并分离出你的网线。如果是一次性绑扎带，用剪刀剪断并换上可松式绑扎带（到章程那儿领取）
1. 完全（参考其他已分离的网线）分离出你的网线后，将网线插入上图交换机


## 外网访问

通过[访问](#访问)小节的外网链接，仅能访问管理界面，如需从外网访问服务器和挂载 NAS，可按如下说明配置 VPN（参考[How To Set Up A Qnap Nas As A VPN Server?](http://qnapsupport.net/how-to-set-up-a-qnap-nas-as-a-vpn-server/)，[如何设置和使用qvpn-2.0](https://www.qnap.com.cn/zh-cn/how-to/tutorial/article/如何设置和使用-qvpn-2-0/)）：
* Windows：
    1. 下载并安装 [OpenVPN](https://openvpn.net/community-downloads/)
    1. 下载本 github 仓库目录下的 [kc110lsc.ovpn](kc110lsc.ovpn) 文件，打开文件按其中的说明自定义配置文件
    1. 打开 OpenVPN，找到“导入配置文件”，选择下载的 .ovpn 文件
    1. 点击连接，输入自己的用户名和密码并确认
* Mac
    1. 从 Tunnelblick 网站安装 [Tunnelblick](https://tunnelblick.net/downloads.html)。
    1. 下载本 github 仓库目录下的 [kc110lsc.ovpn](kc110lsc.ovpn) 文件，打开文件按其中的说明自定义配置文件
    1. 打开 Tunnelblick，双击 OpenVPN 配置文件，将自动导入配置文件。
    1. 单击“Connect”（连接)，输入自己的用户名和密码并确认。

现在你应该可以像在教研室一样访问 NAS 和 GPU 了


## 管理员

* [NAS 管理员说明](README_admin.md)
* [managers 管理员说明](README_managers.md)
