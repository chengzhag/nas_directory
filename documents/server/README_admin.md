# 显卡服务器管理员说明


## 脚本

* 显卡服务器安装脚本：重装系统后以 root 账户运行
    1. 安装 nfs 依赖库，挂载 Public、tmp 文件夹，设置开机自动挂载：[如何在Ubuntu 18.04上设置NFS挂载](https://www.howtoing.com/how-to-set-up-an-nfs-mount-on-ubuntu-18-04)
        ```
        sudo apt install nfs-common
        mkdir /media/Public
        sudo mount 192.168.1.119:/Public /media/Public
        echo "192.168.1.119:/Public /media/Public nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0"  | tee /etc/fstab
		sudo mount 192.168.1.119:/homes /home
		echo "192.168.1.119:/homes /home nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0"  | tee /etc/fstab
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
       1. Nividia 驱动安装
            ```
            # 查看是否禁用nouveau驱动
            lsmod | grep nouveau # 查看是否禁用nouveau驱动
            # 查看。如果没有任何输出就是禁用成功了。否则如下。
            sudo gedit /etc/modprobe.d/blacklist-nouveau.conf
            # 填入以下内容
            blacklist nouveau
            options nouveau modeset=0

            sudo update-initramfs -u
            sudo reboot # 重启电脑

            sudo service lightdm stop # 禁用桌面
            sudo ./NVIDIA-Linux-***.run # 安装特定版本驱动，在Nvidia网站下载

            # 其中安装时的选项
            The distribution-provided pre-install script failed! Are you sure you want to continue? 选择 yes 继续。
            
            Would you like to register the kernel module souces with DKMS? This will allow DKMS to automatically build a new module, if you install a different kernel later? 选择 No 继续。
            
            Nvidia’s 32-bit compatibility libraries? 选择 No 继续。
            
            Would you like to run the nvidia-xconfigutility to automatically update your x configuration so that the NVIDIA x driver will be used when you restart x? Any pre-existing x confile will be backed up. 选择 Yes 继续

            sudo service lightdm start # 启用桌面 
            nvidia-smi # 检查驱动
            ```
        1. Nvidia驱动升级
           ```
           sudo add-apt-repository ppa:graphics-drivers/ppa
           sudo apt update
           ubuntu-drivers devices
           sudo apt install nvidia-driver-*** # 安装指定驱动(这里挑选自己需要的驱动,然后安装即可,不必卸载之前装过的驱动
           sudo reboot # 重启
           ```
        1. cuda安装
 
           到 [CUDA Toolkit Download](https://developer.nvidia.com/cuda-downloads) 下载所需版本 .run文件，以 cuda_9.0.176_384.81_linux.run为例
           ```
           sudo chmod +x cuda_9.0.176_384.81_linux.run
           ./cuda_9.0.176_384.81_linux.run

           Do you accept the previously read EULA?
           accept/decline/quit: accept

           Install NVIDIA Accelerated Graphics Driver for Linux-x86_64 384.81?
           (y)es/(n)o/(q)uit: n # 如果在这之前已经安装好更高版本的显卡驱动就不需要再重复安装，如果需要重复安装就选择 yes,此外还需要关闭图形界面。

           Install the CUDA 9.0 Toolkit?
           (y)es/(n)o/(q)uit: y

           Enter Toolkit Location
           [ default is /usr/local/cuda-9.0 ]: # 一般选择默认即可，也可以选择安装在其他目录，在需要用的时候指向该目录或者使用软连接 link 到 /usr/local/cuda。

           /usr/local/cuda-9.0 is not writable.
           Do you wish to run the installation with 'sudo'?
           (y)es/(n)o: y

           Please enter your password: 
           Do you want to install a symbolic link at /usr/local/cuda? # 是否将安装目录通过软连接的方式 link 到 /usr/local/cuda，yes or no 都可以，取决于你是否使用 /usr/local/cuda 为默认的 cuda 目录。
           (y)es/(n)o/(q)uit: n

           Install the CUDA 9.0 Samples?
           (y)es/(n)o/(q)uit: n

           sudo ln -s /usr/local/cuda-9.0/ /usr/local/cuda/

           export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64
           export PATH=$PATH:/usr/local/cuda/bin
           export CUDA_HOME=$CUDA_HOME:/usr/local/cuda
           source ~/.bashrc

           nvcc --version
           ```  
        1. 对应cudnn安装
           
           对应cuda下载cudnn的安装文件：https://developer.nvidia.com/rdp/cudnn-archive
           ```
           # 解压下载的文件，可以看到cuda文件夹
           sudo cp cuda/include/cudnn.h /usr/local/cuda/include/
 
           sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64/
 
           sudo chmod a+r /usr/local/cuda/include/cudnn.h
 
           sudo chmod a+r /usr/local/cuda/lib64/libcudnn*
           ```
        1. cuda版本切换
           ```
           # 在切换cuda版本时
           rm -rf /usr/local/cuda # 删除之前创建的软链接
           sudo ln -s /usr/local/cuda-*/ /usr/local/cuda/
           nvcc --version #查看当前 cuda 版本
           ```

           



* 用户初始化脚本：.profile, 用户第一次登陆运行
	1. 查找初始化脚本
	2. 更改密码：[Linux 用户和用户组管理](https://www.runoob.com/linux/linux-user-manage.html)
        ```
		passwd ${USER}
        ```
	1. 安装 anaconda
        ```
		bash /media/Public/documents/server/app/Anaconda3-2019.10-Linux-x86_64.sh
        ```
