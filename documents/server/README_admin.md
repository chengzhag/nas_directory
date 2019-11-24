# 显卡服务器管理员说明


## 脚本

* 显卡服务器安装脚本：重装系统后运行
    1. 安装 nfs 依赖库，挂载 Public、tmp 文件夹，设置开机自动挂载：[如何在Ubuntu 18.04上设置NFS挂载](https://www.howtoing.com/how-to-set-up-an-nfs-mount-on-ubuntu-18-04)
        ```
        sudo apt install nfs-common
        mkdir /media/Public
        sudo mount 192.168.1.119:/Public /media/Public
        echo "192.168.1.119:/Public /media/Public nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0"  | tee /etc/fstab
        ```
    1. 修改用户组 sudoer 权限：[sudoers的深入剖析与用户权限控制](https://segmentfault.com/a/1190000007394449)
        ```
        touch /etc/sudoers.d/members
        echo "%members ALL=(ALL)ALL" | tee /etc/sudoers.d/members
        ```
    1. 安装 ldap 依赖库，配置 ldap 服务：[配置Ubuntu使用ldap认证](https://www.iteye.com/blog/wuyaweiwude-1889452)
        ```
        LDAP_SERVER_IP=192.168.1.119
        BASE_DN='dc=kc110lsc,dc=local'
        Root DN: cn=admin,dc=kc110lsc,dc=local
        ```
    1. 安装显卡驱动、cuda、cudnn
* 用户初始化脚本：用户第一次登陆运行，运行结束后删除初始化脚本
	1. 查找初始化脚本
    1. 挂载用户 home、设置开机自动挂载：[如何在Ubuntu 18.04上设置NFS挂载](https://www.howtoing.com/how-to-set-up-an-nfs-mount-on-ubuntu-18-04)
        ```
		mkdir /home/${USER}
		sudo mount 192.168.1.119:/${USER} /home/${USER}
		echo "192.168.1.119:/${USER} /home/${USER} nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0"  | tee /etc/fstab
        ```
	1. 询问默认 shell，并设置 etc/shells 中的 shell：[Changing the shell for users on LDAP auth server](https://www.linuxquestions.org/questions/linux-server-73/changing-the-shell-for-users-on-ldap-auth-server-4175501977/)
        ```
		SHELL=/bin/bash exec /bin/bash
        ```
	1. 更改密码：[Linux 用户和用户组管理](https://www.runoob.com/linux/linux-user-manage.html)
        ```
		passwd ${USER}
        ```
	1. 安装 anaconda
        ```
		bash /media/Public/init/Anaconda3-2019.10-Linux-x86_64.sh
        ```
    1. 删除初始化脚本
